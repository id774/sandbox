#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from pandas import *
from pylab import *
import matplotlib.pyplot as plt
from matplotlib import font_manager
from numpy.random import randn

prop = matplotlib.font_manager.FontProperties(
    fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

r = randn(30).cumsum()
plt.plot(r, color='k', linestyle='dashed', marker='o')

plt.show()
plt.savefig("image.png")

plt.plot(r, color='#ff0000', linestyle='dashed', marker='o', label='dashed')
plt.plot(r, color='#0000ff', drawstyle='steps-post', label='steps-post')
plt.legend(loc='best')

plt.show()
plt.savefig("image2.png")

print(plt.xlim())
print(plt.xticks())

plt.xlim([0, 40])
plt.xticks([0, 4, 8, 12, 16, 20, 24, 28, 32, 36, 40])

print(plt.ylim())
print(plt.yticks())

plt.ylim([-10, 10])
plt.yticks([-10, -8, -6, -4, -2, 0, 2, 4, 6, 8, 10])

plt.show()
plt.savefig("image3.png")

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

r = randn(1000).cumsum()
ax.plot(r)

plt.show()
plt.savefig("image4.png")

ax.set_xticks([0, 250, 500, 750, 1000])
ax.set_xticklabels(['A', 'B', 'C', 'D', 'E'], rotation=30, fontsize='small')
ax.set_title('テストの matplotlib plot です', fontproperties=prop)
ax.set_xlabel('ランク', fontproperties=prop)

plt.show()
plt.savefig("image5.png")

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

def randn1000():
    return randn(1000).cumsum()

ax.plot(randn1000(), 'k', label='one')
ax.plot(randn1000(), 'b--', label='two')
ax.plot(randn1000(), 'r.', label='three')
ax.plot(randn1000(), 'g+', label='four')
ax.plot(randn1000(), 'b*', label='five')

plt.ylim([-100, 100])

ax.legend(loc='best')

plt.show()
plt.savefig("image6.png")
