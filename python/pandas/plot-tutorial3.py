#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from pandas import *
from pylab import *
import matplotlib.pyplot as plt
from matplotlib import font_manager
from numpy.random import randn

s = Series(np.random.randn(10).cumsum(), index=np.arange(0, 100, 10))
s.plot()

plt.show()
plt.savefig("image.png")

df = DataFrame(np.random.randn(10, 4).cumsum(0),
               columns=['A', 'B', 'C', 'D'],
               index=np.arange(0, 100, 10))
df.plot()
plt.show()
plt.savefig("image2.png")

fig, axes = plt.subplots(2, 1)

data = Series(np.random.randn(16), index=list('abcdefghijklmnop'))
data.plot(kind='bar', ax=axes[0], color='k', alpha=0.7)
data.plot(kind='barh', ax=axes[1], color='r', alpha=0.6)

plt.show()
plt.savefig("image3.png")

df = DataFrame(np.random.randn(6, 4),
               index=['1', '2', '3', '4', '5', '6'],
               columns=Index(['A', 'B', 'C', 'D'], name='Genus'))
print(df)

df.plot()
plt.show()
plt.savefig("image4.png")

df.plot(kind='bar')
plt.show(grid=False, alpha=0.8)
plt.savefig("image5.png")

df.plot(kind='barh', stacked=True, alpha=0.5)
plt.show()
plt.savefig("image6.png")

df = read_csv('stock_px.csv')
print(df.head(10))
df.plot()
plt.show()
plt.savefig("image7.png")
