import math
from functools import partial

import tensorflow as tf
from tensorflow.compat.v1.keras import backend as K

# from utils.utils_bbox import get_anchors_and_decode


def box_ciou(b1, b2):
    """
    输入为：
    ----------
    b1: tensor, shape=(batch, feat_w, feat_h, anchor_num, 4), xywh
    b2: tensor, shape=(batch, feat_w, feat_h, anchor_num, 4), xywh

    返回为：
    -------
    ciou: tensor, shape=(batch, feat_w, feat_h, anchor_num, 1)
    """
    #-----------------------------------------------------------#
    #   求出预测框左上角右下角
    #   b1_mins     (batch, feat_w, feat_h, anchor_num, 2)
    #   b1_maxes    (batch, feat_w, feat_h, anchor_num, 2)
    #-----------------------------------------------------------#
    b1_xy = b1[..., :2]
    b1_wh = b1[..., 2:4]
    b1_wh_half = b1_wh/2.
    b1_mins = b1_xy - b1_wh_half
    b1_maxes = b1_xy + b1_wh_half
    #-----------------------------------------------------------#
    #   求出真实框左上角右下角
    #   b2_mins     (batch, feat_w, feat_h, anchor_num, 2)
    #   b2_maxes    (batch, feat_w, feat_h, anchor_num, 2)
    #-----------------------------------------------------------#
    b2_xy = b2[..., :2]
    b2_wh = b2[..., 2:4]
    b2_wh_half = b2_wh/2.
    b2_mins = b2_xy - b2_wh_half
    b2_maxes = b2_xy + b2_wh_half

    #-----------------------------------------------------------#
    #   求真实框和预测框所有的iou
    #   iou         (batch, feat_w, feat_h, anchor_num)
    #-----------------------------------------------------------#
    intersect_mins = K.maximum(b1_mins, b2_mins)
    intersect_maxes = K.minimum(b1_maxes, b2_maxes)
    intersect_wh = K.maximum(intersect_maxes - intersect_mins, 0.)
    intersect_area = intersect_wh[..., 0] * intersect_wh[..., 1]
    b1_area = b1_wh[..., 0] * b1_wh[..., 1]
    b2_area = b2_wh[..., 0] * b2_wh[..., 1]
    union_area = b1_area + b2_area - intersect_area
    iou = intersect_area / K.maximum(union_area, K.epsilon())

    #-----------------------------------------------------------#
    #   计算中心的差距
    #   center_distance (batch, feat_w, feat_h, anchor_num)
    #-----------------------------------------------------------#
    center_distance = K.sum(K.square(b1_xy - b2_xy), axis=-1)
    enclose_mins = K.minimum(b1_mins, b2_mins)
    enclose_maxes = K.maximum(b1_maxes, b2_maxes)
    enclose_wh = K.maximum(enclose_maxes - enclose_mins, 0.0)
    #-----------------------------------------------------------#
    #   计算对角线距离
    #   enclose_diagonal (batch, feat_w, feat_h, anchor_num)
    #-----------------------------------------------------------#
    enclose_diagonal = K.sum(K.square(enclose_wh), axis=-1)
    ciou = iou - 1.0 * (center_distance) / K.maximum(enclose_diagonal ,K.epsilon())
    
    v = 4 * K.square(tf.math.atan2(b1_wh[..., 0], K.maximum(b1_wh[..., 1], K.epsilon())) - tf.math.atan2(b2_wh[..., 0], K.maximum(b2_wh[..., 1],K.epsilon()))) / (math.pi * math.pi)
    alpha = v /  K.maximum((1.0 - iou + v), K.epsilon())
    ciou = ciou - alpha * v

    ciou = K.expand_dims(ciou, -1)
    return ciou

#---------------------------------------------------#
#   平滑标签
#---------------------------------------------------#
def _smooth_labels(y_true, label_smoothing):
    num_classes = tf.cast(K.shape(y_true)[-1], dtype=K.floatx())
    label_smoothing = K.constant(label_smoothing, dtype=K.floatx())
    return y_true * (1.0 - label_smoothing) + label_smoothing / num_classes
    
#---------------------------------------------------#
#   用于计算每个预测框与真实框的iou
#---------------------------------------------------#
def box_iou(b1, b2):
    #---------------------------------------------------#
    #   num_anchor,1,4
    #   计算左上角的坐标和右下角的坐标
    #---------------------------------------------------#
    b1              = K.expand_dims(b1, -2)
    b1_xy           = b1[..., :2]
    b1_wh           = b1[..., 2:4]
    b1_wh_half      = b1_wh/2.
    b1_mins         = b1_xy - b1_wh_half
    b1_maxes        = b1_xy + b1_wh_half

    #---------------------------------------------------#
    #   1,n,4
    #   计算左上角和右下角的坐标
    #---------------------------------------------------#
    b2              = K.expand_dims(b2, 0)
    b2_xy           = b2[..., :2]
    b2_wh           = b2[..., 2:4]
    b2_wh_half      = b2_wh/2.
    b2_mins         = b2_xy - b2_wh_half
    b2_maxes        = b2_xy + b2_wh_half

    #---------------------------------------------------#
    #   计算重合面积
    #---------------------------------------------------#
    intersect_mins  = K.maximum(b1_mins, b2_mins)
    intersect_maxes = K.minimum(b1_maxes, b2_maxes)
    intersect_wh    = K.maximum(intersect_maxes - intersect_mins, 0.)
    intersect_area  = intersect_wh[..., 0] * intersect_wh[..., 1]
    b1_area         = b1_wh[..., 0] * b1_wh[..., 1]
    b2_area         = b2_wh[..., 0] * b2_wh[..., 1]
    iou             = intersect_area / (b1_area + b2_area - intersect_area)

    return iou

#---------------------------------------------------#
#   loss值计算
#---------------------------------------------------#
def yolo_loss(
    args, 
    input_shape, 
    anchors, 
    anchors_mask, 
    num_classes, 
    balance         = [0.4, 1.0, 4], 
    label_smoothing = 0.01, 
    box_ratio       = 0.05, 
    obj_ratio       = 1, 
    cls_ratio       = 0.5
):
    num_layers = len(anchors_mask)
    #---------------------------------------------------------------------------------------------------#
    #   将预测结果和实际ground truth分开，args是[*model_body.output, *y_true]
    #   y_true是一个列表，包含三个特征层，shape分别为:
    #   (m,20,20,3,85)
    #   (m,40,40,3,85)
    #   (m,80,80,3,85)
    #   yolo_outputs是一个列表，包含三个特征层，shape分别为:
    #   (m,20,20,3,85)
    #   (m,40,40,3,85)
    #   (m,80,80,3,85)
    #---------------------------------------------------------------------------------------------------#
    y_true          = args[num_layers:]
    yolo_outputs    = args[:num_layers]

    #-----------------------------------------------------------#
    #   得到input_shpae为640,640
    #-----------------------------------------------------------#
    input_shape = K.cast(input_shape, K.dtype(y_true[0]))

    loss    = 0
    #---------------------------------------------------------------------------------------------------#
    #   y_true是一个列表，包含三个特征层，shape分别为(m,20,20,3,85),(m,40,40,3,85),(m,80,80,3,85)。
    #   yolo_outputs是一个列表，包含三个特征层，shape分别为(m,20,20,3,85),(m,40,40,3,85),(m,80,80,3,85)。
    #---------------------------------------------------------------------------------------------------#
    for l in range(num_layers):
        #-----------------------------------------------------------#
        #   以第一个特征层(m,20,20,3,85)为例子
        #   取出该特征层中存在目标的点的位置。(m,20,20,3,1)
        #-----------------------------------------------------------#
        object_mask = y_true[l][..., 4:5]
        #-----------------------------------------------------------#
        #   取出其对应的种类(m,20,20,3,num_classes)
        #-----------------------------------------------------------#
        true_class_probs = y_true[l][..., 5:]
        if label_smoothing:
            true_class_probs = _smooth_labels(true_class_probs, label_smoothing)

        #-----------------------------------------------------------#
        #   将yolo_outputs的特征层输出进行处理、获得四个返回值
        #   其中：
        #   grid        (20,20,1,2) 网格坐标
        #   raw_pred    (m,20,20,3,85) 尚未处理的预测结果
        #   pred_xy     (m,20,20,3,2) 解码后的中心坐标
        #   pred_wh     (m,20,20,3,2) 解码后的宽高坐标
        #-----------------------------------------------------------#


        feats_ = yolo_outputs[l]
        anchors_ = anchors[anchors_mask[l]]

        num_classes_ = num_classes
        input_shape_ = input_shape
        calc_loss_ = True
        # ---------------------------------------------------#
        #   计算先验框的数量，num_anchors = 3
        # ---------------------------------------------------#
        num_anchors_ = len(anchors_)
        # ------------------------------------------#
        #   grid_shape指的是特征层的高和宽
        # ------------------------------------------#
        grid_shape_ = K.shape(feats_)[1:3]
        # --------------------------------------------------------------------#
        #   获得各个特征点的坐标信息。生成的shape为(20, 20, num_anchors, 2)
        # --------------------------------------------------------------------#
        grid_x_ = K.tile(K.reshape(K.arange(0, stop=grid_shape_[1]), [1, -1, 1, 1]),
                        [grid_shape_[0], 1, num_anchors_, 1])
        grid_y_ = K.tile(K.reshape(K.arange(0, stop=grid_shape_[0]), [-1, 1, 1, 1]),
                        [1, grid_shape_[1], num_anchors_, 1])
        grid_ = K.cast(K.concatenate([grid_x_, grid_y_]), K.dtype(feats_))
        # ---------------------------------------------------------------#
        #   将先验框进行拓展，生成的shape为(20, 20, num_anchors, 2)
        # ---------------------------------------------------------------#
        anchors_tensor_ = K.reshape(K.constant(anchors_), [1, 1, num_anchors_, 2])
        anchors_tensor_ = K.tile(anchors_tensor_, [grid_shape_[0], grid_shape_[1], 1, 1])

        # ---------------------------------------------------#
        #   将预测结果调整成(batch_size, 20, 20, 3, 85)
        #   85可拆分成4 + 1 + 80
        #   4代表的是中心宽高的调整参数
        #   1代表的是框的置信度
        #   80代表的是种类的置信度
        #   batch_size, 20, 20, 3, 5 + num_classes
        # ---------------------------------------------------#
        feats_ = K.reshape(feats_, [-1, grid_shape_[0], grid_shape_[1], num_anchors_, num_classes_ + 5])
        # ------------------------------------------#
        #   对先验框进行解码，并进行归一化
        # ------------------------------------------#
        box_xy_ = (K.sigmoid(feats_[..., :2]) * 2 - 0.5 + grid_) / K.cast(grid_shape_[::-1], K.dtype(feats_))
        box_wh_ = (K.sigmoid(feats_[..., 2:4]) * 2) ** 2 * anchors_tensor_ / K.cast(input_shape_[::-1], K.dtype(feats_))
        # ------------------------------------------#
        #   获得预测框的置信度
        # ------------------------------------------#
        box_confidence_ = K.sigmoid(feats_[..., 4:5])
        box_class_probs_ = K.sigmoid(feats_[..., 5:])

        # ---------------------------------------------------------------------#
        #   在计算loss的时候返回grid, feats, box_xy, box_wh
        #   在预测的时候返回box_xy, box_wh, box_confidence, box_class_probs
        # ---------------------------------------------------------------------#
        if calc_loss_ is True:
            grid = grid_
            raw_pred = feats_
            pred_xy = box_xy_
            pred_wh = box_wh_

        else:
            grid = box_xy_
            raw_pred = box_wh_
            pred_xy = box_confidence_
            pred_wh = box_class_probs_


        # grid, raw_pred, pred_xy, pred_wh = get_anchors_and_decode(yolo_outputs[l], anchors[anchors_mask[l]], num_classes, input_shape, calc_loss=True)
        
        #-----------------------------------------------------------#
        #   pred_box是解码后的预测的box的位置
        #   (m,20,20,3,4)
        #-----------------------------------------------------------#
        pred_box = K.concatenate([pred_xy, pred_wh])

        #-----------------------------------------------------------#
        #   计算Ciou loss
        #   raw_true_box 前四个序号的内容是当前这个先验框对应的真实框坐标
        #   pred_box     每一个特征点每个先验框的预测结果
        #   box_ciou(pred_box, raw_true_box) 计算每一个特征点上每一个先验框，预测结果和真实情况的ciou
        #   object_mask  正样本的mask，用于选取正样本，只有正样本才可以计算回归损失。
        #-----------------------------------------------------------#
        raw_true_box    = y_true[l][...,0:4]
        ciou            = box_ciou(pred_box, raw_true_box)
        ciou_loss       = object_mask * (1 - ciou)
        
        #------------------------------------------------------------------------------#
        #   先去计算每一个正样本和当前预测框的重合程度
        #   使用正样本真实框与预测框的重合程度，作为当前正样本内部是否包含目标的标签
        #   
        #   当前的先验框预测越准确，这个先验框才负责这个真实框的预测。
        #------------------------------------------------------------------------------#
        tobj            = tf.where(tf.equal(object_mask, 1), tf.maximum(ciou, tf.zeros_like(ciou)), tf.zeros_like(ciou))
        confidence_loss = K.binary_crossentropy(tobj, raw_pred[..., 4:5], from_logits=True)

        #-----------------------------------------------------------#
        #   计算分类损失
        #-----------------------------------------------------------#
        class_loss      = object_mask * K.binary_crossentropy(true_class_probs, raw_pred[...,5:], from_logits=True)

        #-----------------------------------------------------------#
        #   计算正样本数量
        #-----------------------------------------------------------#
        num_pos         = tf.maximum(K.sum(K.cast(object_mask, tf.float32)), 1)

        location_loss   = K.sum(ciou_loss) * box_ratio / num_pos
        confidence_loss = K.mean(confidence_loss) * balance[l] * obj_ratio
        class_loss      = K.sum(class_loss) * cls_ratio / num_pos / num_classes

        loss    += location_loss + confidence_loss + class_loss
        # if print_loss:
        # loss = tf.Print(loss, [loss, location_loss, confidence_loss, class_loss], message='loss: ')
        
    return loss


def get_lr_scheduler(lr_decay_type, lr, min_lr, total_iters, warmup_iters_ratio = 0.05, warmup_lr_ratio = 0.1, no_aug_iter_ratio = 0.05, step_num = 10):
    def yolox_warm_cos_lr(lr, min_lr, total_iters, warmup_total_iters, warmup_lr_start, no_aug_iter, iters):
        if iters <= warmup_total_iters:
            # lr = (lr - warmup_lr_start) * iters / float(warmup_total_iters) + warmup_lr_start
            lr = (lr - warmup_lr_start) * pow(iters / float(warmup_total_iters), 2
            ) + warmup_lr_start
        elif iters >= total_iters - no_aug_iter:
            lr = min_lr
        else:
            lr = min_lr + 0.5 * (lr - min_lr) * (
                1.0
                + math.cos(
                    math.pi
                    * (iters - warmup_total_iters)
                    / (total_iters - warmup_total_iters - no_aug_iter)
                )
            )
        return lr

    def step_lr(lr, decay_rate, step_size, iters):
        if step_size < 1:
            raise ValueError("step_size must above 1.")
        n       = iters // step_size
        out_lr  = lr * decay_rate ** n
        return out_lr

    if lr_decay_type == "cos":
        warmup_total_iters  = min(max(warmup_iters_ratio * total_iters, 1), 3)
        warmup_lr_start     = max(warmup_lr_ratio * lr, 1e-6)
        no_aug_iter         = min(max(no_aug_iter_ratio * total_iters, 1), 15)
        func = partial(yolox_warm_cos_lr ,lr, min_lr, total_iters, warmup_total_iters, warmup_lr_start, no_aug_iter)
    else:
        decay_rate  = (min_lr / lr) ** (1 / (step_num - 1))
        step_size   = total_iters / step_num
        func = partial(step_lr, lr, decay_rate, step_size)

    return func
