#-------------------------------------------------------#
#   用于处理COCO数据集，根据json文件生成txt文件用于训练
#-------------------------------------------------------#
import glob
import json
import os
from collections import defaultdict

#-------------------------------------------------------#
#   指向了COCO训练集与验证集图片的路径
#-------------------------------------------------------#
train_datasets_path     = "dataset/images/train2017"
val_datasets_path       = "dataset/images/train2017"

#-------------------------------------------------------#
#   指向了COCO训练集与验证集标签的路径
#-------------------------------------------------------#
train_annotation_path   = "dataset/labels/train2017"
val_annotation_path     = "dataset/labels/train2017"

#-------------------------------------------------------#
#   生成的txt文件路径
#-------------------------------------------------------#
train_output_path       = "dataset/2017_train.txt"
val_output_path         = "dataset/2017_val.txt"

if __name__ == "__main__":

    train_list = glob.glob(train_datasets_path + "/*.jpg")

    with open(train_output_path, 'w') as f:

        for i, image_file in enumerate(train_list):
            label_basename = os.path.basename(image_file).split('.')[0]
            label_path = os.path.join(train_annotation_path, label_basename + '.txt')
            try:
                with open(label_path, 'r') as txt:
                    lines = txt.readlines()
                    boxes = [line.split() for line in lines]
            except IOError as e:
                continue


            f.write(image_file)
            for box in boxes:
                cls, x, y, w, h = box
                f.write(" {},{},{},{},{}".format(x, y, w, h, cls))
            if i != len(train_list) - 1:
                f.write("\n")
