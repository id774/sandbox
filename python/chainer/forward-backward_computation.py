# IPython log file


import numpy as np
import chainer
from chainer import Function
from chainer import Variable
from chainer import cuda
from chainer import gradient_check
from chainer import optimizers
from chainer import serializers
from chainer import utils
from chainer import Chain
from chainer import ChainList
from chainer import Link
import chainer.functions as F
import chainer.links as L
x_data = np.array([5], dtype=np.float32)
x = Variable(x_data)
x
y = x ** 2 - 2 * x + 1
y
y.data
x.data
y.backward()
g = x.grad
print(g)
z = 2 * x
print(z.data)
y = x ** 2 - z + 1
print(y.data)
y.backward(retain_grad=True)
g = z.grad
print(g)
x = Variable(np.array([[1, 2, 3], [4, 5, 6]], dtype=np.float32))
y = x ** 2 - 2 * x + 1
y.grad = np.ones((2, 3), dtype=np.float32)
y.backward()
g = x.grad
print(g)
