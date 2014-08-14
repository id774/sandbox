#!/usr/bin/env python
# -*- coding: utf-8 -*-

from pylab import *
from pandas import *
import matplotlib.pyplot as plt
import numpy as np
from matplotlib import font_manager

fontprop = matplotlib.font_manager.FontProperties(
    fname="/usr/share/fonts/truetype/fonts-japanese-gothic.ttf")

ts = Series(randn(1000), index=date_range('1/1/2000', periods=1000))
ts = ts.cumsum()

ts.plot()

plt.show()
plt.savefig("image.png")

df = DataFrame(randn(1000, 4), index=ts.index, columns=list('ABCD'))
df = df.cumsum()

plt.figure()
df.plot()

plt.legend(loc='best')

ax = df.plot(secondary_y=['A', 'B'])
ax.set_ylabel('CD の売上', fontdict={"fontproperties": fontprop})
ax.right_ax.set_ylabel('AB スケール', fontdict={"fontproperties": fontprop})

plt.show()
plt.savefig("image2.png")

df.plot(subplots=True, figsize=(6, 6))
plt.legend(loc='best')

plt.show()
plt.savefig("image3.png")

fig, axes = plt.subplots(nrows=2, ncols=2)
df['A'].plot(ax=axes[0, 0])
axes[0, 0].set_title('A')
df['B'].plot(ax=axes[0, 1])
axes[0, 1].set_title('B')
df['C'].plot(ax=axes[1, 0])
axes[1, 0].set_title('C')
df['D'].plot(ax=axes[1, 1])
axes[1, 1].set_title('D')

plt.show()
plt.savefig("image4.png")

plt.figure()
df.ix[5].plot(kind='bar')
plt.axhline(0, color='k')

plt.show()
plt.savefig("image5.png")

df2 = DataFrame(rand(10, 4), columns=['a', 'b', 'c', 'd'])
df2.plot(kind='bar')

plt.show()
plt.savefig("image6.png")

df2.plot(kind='barh', stacked=True)
plt.figure()
df['A'].diff().hist()

plt.show()
plt.savefig("image7.png")

df.diff().hist(color='k', alpha=0.5, bins=50)
plt.show()
plt.savefig("image8.png")

data = Series(randn(1000))
data.hist(by=randint(0, 4, 1000), figsize=(6, 4))
plt.show()
plt.savefig("image9.png")

from pandas.tools.plotting import scatter_matrix
df = DataFrame(randn(1000, 4), columns=['a', 'b', 'c', 'd'])
scatter_matrix(df, alpha=0.2, figsize=(6, 6), diagonal='kde')

plt.show()
plt.savefig("image11.png")

from pandas.tools.plotting import bootstrap_plot
data = Series(rand(1000))
bootstrap_plot(data, size=50, samples=500, color='grey')
plt.show()
plt.savefig("image12.png")

df = DataFrame(randn(1000, 10), index=ts.index)
df = df.cumsum()
plt.figure()
df.plot(colormap='jet')
plt.show()
plt.savefig("image13.png")

dd = DataFrame(randn(10, 10)).applymap(abs)
dd = dd.cumsum()
plt.figure()
dd.plot(kind='bar', colormap='Greens')
plt.show()
plt.savefig("image14.png")
