
import tensorflow.compat.v1.keras.backend as K

import numpy as np

import tensorflow as tf
import tensorflow.compat.v1.keras as keras
from tensorflow.python.keras import Model
from tensorflow.python.keras.engine.base_layer import Layer
from tensorflow.python.keras.layers import Input, Dense, Conv2D, BatchNormalization

import tensorflow_model_optimization as tfmot  # 量化工具包

quantize_annotate_layer = tfmot.quantization.keras.quantize_annotate_layer  # 标记量化层
quantize_apply = tfmot.quantization.keras.quantize_apply  # 使能标记量化层真正被量化
quantize_model = tfmot.quantization.keras.quantize_model  # 量化整个模型
quantize_scope = tfmot.quantization.keras.quantize_scope  # 定义量化工作空间(load&quantize model时使用，用于传入自定义的量化配置)
LastValueQuantizer = tfmot.quantization.keras.quantizers.LastValueQuantizer  # （根据范围的最后一批值量化张量，默认用于参数量化器）
MovingAverageQuantizer = tfmot.quantization.keras.quantizers.MovingAverageQuantizer  # （根据各批次值的移动平均值对张量进行量化，默认用于激活量化器）

# 定义要量化的卷积层名称和量化比例
quantize_layers = ['conv2d_36', 'conv2d_39', 'conv2d_42']
quantize_ratios = [0.8, 0.5, 0.2]  # 对应每个卷积层的量化比例

# 定义要评估的推理准确率损失阈值
# accuracy_losses = [0.02, 0.05, 0.1]
accuracy_losses = [0.02]



class DefaultDenseQuantizeConfig(tfmot.quantization.keras.QuantizeConfig):
    # Configure how to quantize weights.
    def __init__(self, num_bits):
        super(DefaultDenseQuantizeConfig, self).__init__()
        self.num_bits = num_bits

    # def get_weights_and_quantizers(self, layer):
    #     return [(layer.kernel, LastValueQuantizer(num_bits=self.num_bits, symmetric=True, narrow_range=False, per_axis=False)),
    #             (layer.bias, LastValueQuantizer(num_bits=self.num_bits, symmetric=True, narrow_range=False, per_axis=False))]
    def get_weights_and_quantizers(self, layer):
        return [
            (layer.kernel, LastValueQuantizer(num_bits=self.num_bits, symmetric=True, narrow_range=False, per_axis=False))] if layer.use_bias is False else\
            [(layer.kernel, LastValueQuantizer(num_bits=self.num_bits, symmetric=True, narrow_range=False, per_axis=False)),
            (layer.bias, LastValueQuantizer(num_bits=self.num_bits, symmetric=True, narrow_range=False, per_axis=False))]

    # Configure how to quantize activations.
    def get_activations_and_quantizers(self, layer):
        return [
            (layer.activation, MovingAverageQuantizer(num_bits=self.num_bits, symmetric=False, narrow_range=False, per_axis=False))]

    def set_quantize_weights(self, layer, quantize_weights):
        # Add this line for each item returned in `get_weights_and_quantizers`
        # , in the same order
        layer.kernel = quantize_weights[0]
        if layer.use_bias is True:
            layer.bias = quantize_weights[1]

    def set_quantize_activations(self, layer, quantize_activations):
        # Add this line for each item returned in `get_activations_and_quantizers`
        # , in the same order.
        layer.activation = quantize_activations[0]

    # Configure how to quantize outputs (may be equivalent to activations).
    def get_output_quantizers(self, layer):
        return []

    def get_config(self):
        return {}


class MDQC(DefaultDenseQuantizeConfig):
    def __init__(self, num_bits=8):
        super(MDQC, self).__init__(num_bits)

    def get_activations_and_quantizers(self, layer):
        # Skip quantizing activations.
        return []

    def set_quantize_activations(self, layer, quantize_activations):
        # Empty since `get_activations_and_quantizers` returns
        # an empty list.
        return


class SiLU(Layer):
    def __init__(self, **kwargs):
        super(SiLU, self).__init__(**kwargs)
        self.supports_masking = True

    def call(self, inputs):
        return inputs * K.sigmoid(inputs)

    def get_config(self):
        config = super(SiLU, self).get_config()
        return config

    def compute_output_shape(self, input_shape):
        return input_shape


def yolo_body(input_shape):

    inputs      = Input(input_shape)
    #---------------------------------------------------#
    #   生成主干模型，获得三个有效特征层，他们的shape分别是：
    #   80, 80, 256
    #   40, 40, 512
    #   20, 20, 1024
    #---------------------------------------------------#

    x = Conv2D(filters=32, kernel_size=3, padding='same', use_bias=False, name='first.conv')(inputs)
    x = BatchNormalization(momentum=0.97, epsilon=0.001, name='first.bn')(x)
    x = SiLU()(x)
    x = Conv2D(filters=64, kernel_size=3, padding='same', use_bias=False, name='second.conv')(x)
    x = BatchNormalization(momentum=0.97, epsilon=0.001, name='second.bn')(x)

    outputs = x

    return Model(inputs, [outputs, outputs])


model = yolo_body((None, None, 3))

y = model.predict(np.ones((1, 640, 640, 3)), verbose=True)


with quantize_scope({'MDQC': MDQC, "SiLU": SiLU}):

    def apply_quantization(layer):
        quantize_config = MDQC(num_bits=8)

        if layer.name == 'first.conv':
            return tfmot.quantization.keras.quantize_annotate_layer(layer, quantize_config)

        return layer


    annotated_model = tf.keras.models.clone_model(
        model, clone_function=apply_quantization,
    )

    quantized_model = tfmot.quantization.keras.quantize_apply(annotated_model)

    quantized_model.summary()

    # quantized_model.compile(optimizer="adam", loss={'yolo_loss': lambda y_true, y_pred: y_pred})

y = quantized_model.predict(np.ones((1, 640, 640, 3)), verbose=True)


#
# with quantize_scope({'MDQC': MDQC, "NoOpQuantizeConfig": NoOpQuantizeConfig}):
#     # Use `quantize_apply` to actually make the model quantization aware.
#
#     def apply_quantization(layer):
#         quantize_config = MDQC(num_bits=8)
#         # if 'conv' in layer.name and 'bn' not in layer.name:
#         if layer.name == 'backbone.stem.conv.conv':
#             return tfmot.quantization.keras.quantize_annotate_layer(layer, quantize_config)
#         # else:
#         #     return tfmot.quantization.keras.quantize_annotate_layer(layer)
#         return layer

    #
    # annotated_adv_model = tf.keras.models.clone_model(
    #     model, clone_function=apply_quantization,
    # )
    # with tf.keras.utils.custom_object_scope(
    #         {"NoOpQuantizeConfig": NoOpQuantizeConfig, "MDQC": MDQC, "Focus": Focus, "SiLU": SiLU}):


# with quantize_scope():
#     # quant_model = tfmot.quantization.keras.quantize_model(annotated_adv_model)
#     # To quantized specific layers as previous example, this also work.
#     quantized_model = tfmot.quantization.keras.quantize_apply(model)
#     # quantized_model.set_weights(model.get_weights())
#     # quantized_model.load_weights(self.model_path)
#     quantized_model.summary()


sess = K.get_session()

            # quantized_model.compile(optimizer="adam", loss={'yolo_loss': lambda y_true, y_pred: y_pred})

    # model = quantize_apply(model)

    # 对量化后的模型进行评估
    # quantized_model = tf.python.keras.models.clone_model(model)
    # quantized_model.set_weights(model.get_weights())
pass