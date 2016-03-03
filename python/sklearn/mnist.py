import numpy as np
import pylab
from sklearn.datasets import fetch_mldata

print('fetch MNIST dataset...')
mnist = fetch_mldata('MNIST original', data_home=".")
print('OK')

p = np.random.random_integers(0, len(mnist.data), 25)

for index, (data, label) in enumerate(np.array(list(zip(mnist.data, mnist.target)))[p]):
    pylab.subplot(5, 5, index + 1)
    pylab.axis('off')
    pylab.imshow(
        data.reshape(28, 28), cmap=pylab.cm.gray_r, interpolation='nearest')
    pylab.title('%i' % label)
pylab.show()
pylab.savefig('image.png')
