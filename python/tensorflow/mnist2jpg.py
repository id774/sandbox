# mnist2jpg.py: Save MNIST images as JPEG files
#
# Description:
# Convert MNIST images read from train.images.csv and train.labels.csv into
# JPEG files with NumPy and Pillow.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 mnist2jpg.py
#
# Requirements:
# - Python 3
# - NumPy and Pillow
#

# mnist = input_data.read_data_sets('MNIST_data', one_hot=True)

import numpy as np
from PIL import Image

mnist_train_images = np.loadtxt('train.images.csv', delimiter=',')
mnist_train_labels = np.loadtxt('train.labels.csv', delimiter=',')

im = Image.new('RGB', (28, 28), (255, 255, 255))

counter = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]

for i in range(len(mnist_train_images)):
    for l in range(len(mnist_train_labels[i])):
        if mnist_train_labels[i, l] > 0:
            label = l
    for y in range(28):
        for x in range(28):
            w = mnist_train_images[i, y * 28 + x]
            w = 255 - int(w * 255)
            im.putpixel((x, y), (w, w, w))
    filename = 'images/' + str(label) + '_' + \
        str(counter[label]).zfill(4) + '.jpg'
    im.save(filename, 'JPEG', quality=100, optimize=True)
    counter[label] = counter[label] + 1
    if i % 1000 == 0:
        print(str(i) + ' images completed.')
i += 1

for label in range(10):
    print('number ' + str(label) + ' : ' +
          str(counter[label]) + ' images converted.')
print('total : ' + str(i) + ' images completed.')
