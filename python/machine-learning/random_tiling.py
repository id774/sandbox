# -*- coding:utf-8 -*-

import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np

img = np.random.rand(32,32)
plt.imshow(img)

plt.show()
plt.savefig("image.png")

plt.gray()

plt.show()
plt.savefig("image2.png")

plt.hot()

plt.show()
plt.savefig("image3.png")
