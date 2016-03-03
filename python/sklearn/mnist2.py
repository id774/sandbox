import re
import numpy as np
import matplotlib.pyplot as plt
from matplotlib import cm
from sklearn.datasets import fetch_mldata
from PIL import Image

print('fetch MNIST dataset...')
mnist = fetch_mldata('MNIST original', data_home=".")
print('OK')

p = np.random.random_integers(0, len(mnist.data), 25)
X = mnist.data
y = mnist.target

print(X[0])
print(y[0])

samples = np.array(list(zip(X, y)))[p]
for index, (data, label) in enumerate(samples):
     plt.subplot(5, 5, index + 1)
     plt.axis('off')
     plt.imshow(data.reshape(28, 28), cmap=cm.gray_r, interpolation='nearest')
     plt.title(str(int(label)), color='red')

plt.show()
plt.savefig('image.png')
img = Image.open('image.png', "r")
width, height = img.size
newfilename = re.search("(?<!\.)\w+", 'image.png').group(0) + "." + 'jpg'
canvas = Image.new("RGB", (width, height), (255, 255, 255))
canvas.paste(img, (0, 0))
canvas.save(newfilename, "JPEG", quality=100, optimize=True)
