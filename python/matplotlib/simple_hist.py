# -*- coding:utf-8 -*-

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab

x = np.array([236, 330, 375, 392, 460, 525, 578])
mu, sigma = 170, 5

plt.title("Test")
plt.grid(True)
plt.xlabel('X')
plt.ylabel('Y')

n, bins, patches = plt.hist(x, alpha=0.75, align='mid')
y = mlab.normpdf(bins, mu, sigma)
plt.plot(bins, y, 'r-', linewidth=1)

plt.show()
plt.savefig("image.png")

