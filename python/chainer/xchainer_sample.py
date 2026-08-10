
# http://blog.recruit-tech.co.jp/2015/09/02/xchainer-released/

from xchainer import NNmanager
import numpy as np
from chainer import FunctionSet, Variable, optimizers
import chainer.functions as F
from sklearn.base import ClassifierMixin

# Inherit from NNmanager and ClassifierMixin
class MnistSimple(NNmanager, ClassifierMixin):

    def __init__(self, logging=False):
        # Define the network structure
        model = FunctionSet(
            l1=F.Linear(784, 100),
            l2=F.Linear(100, 100),
            l3=F.Linear(100, 10)
        )
        # Choose the optimization method
        optimizer = optimizers.SGD()
        # Choose the loss function
        lossFunction = F.softmax_cross_entropy
        # Set the parameters
        params = {'epoch': 20, 'batchsize': 100, 'logging': logging}
        NNmanager.__init__(self, model, optimizer, lossFunction, **params)

    def trimOutput(self, output):
        y_trimed = output.data.argmax(axis=1)
        return np.array(y_trimed, dtype=np.int32)

    def forward(self, x_batch, **options):
        x = Variable(x_batch)
        h1 = F.relu(self.model.l1(x))
        h2 = F.relu(self.model.l2(h1))
        output = F.relu(self.model.l3(h2))
        return output
