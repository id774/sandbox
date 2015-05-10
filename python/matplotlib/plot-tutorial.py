#!/usr/bin/env python
# -*- coding: utf-8 -*-

import sys
import numpy as np
from pandas import *
from pylab import *
import matplotlib.pyplot as plt
from matplotlib import font_manager
from numpy.random import randn

if sys.platform == "darwin":
    font_path = "/Library/Fonts/Osaka.ttf"
else:
    font_path = "/usr/share/fonts/truetype/fonts-japanese-gothic.ttf"

fontprop = font_manager.FontProperties(fname=font_path)

fig = plt.figure()

ax1 = fig.add_subplot(2, 2, 1)
ax2 = fig.add_subplot(2, 2, 2)
ax3 = fig.add_subplot(2, 2, 3)

plt.show()
plt.savefig("image.png")

ran = randn(50).cumsum()
print(ran)
plt.plot(ran, 'k--')

plt.show()
plt.savefig("image2.png")

ax1.hist(rand(100), bins=20, color='k', alpha=0.3)
ax2.scatter(np.arange(30), np.arange(30) + 3 * randn(30))

plt.show()
plt.savefig("image3.png")

fig, axes = plt.subplots(2, 2, sharex=True, sharey=True)
for i in range(2):
    for j in range(2):
        axes[i, j].hist(randn(500), bins=50, color='k', alpha=0.5)
plt.subplots_adjust(
    left=None, bottom=None, right=None, top=None, wspace=0, hspace=0)

plt.show()
plt.savefig("image4.png")
