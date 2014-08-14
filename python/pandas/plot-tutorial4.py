#!/usr/bin/env python
# -*- coding: utf-8 -*-

import numpy as np
from pandas import *
import matplotlib.pyplot as plt

tips = read_csv('tips.csv', sep=',')

party_counts = crosstab(tips.day, tips.size)
print(party_counts)

# 1 人と 6 人のデータを削除
#party_counts = party_counts.ix[:, 2:5]
#print( party_counts )

party_counts = party_counts.div(party_counts.sum(1), axis=0)
print(party_counts)

party_counts.plot(kind='bar', stacked=True)

plt.show()
plt.savefig("image.png")

fig = plt.figure()
ax1 = fig.add_subplot(2, 1, 1)
ax2 = fig.add_subplot(2, 1, 2)

tips['tip_pct'] = tips['tip'] / tips['total_bill']
result = tips['tip_pct']

result.plot(kind='kde')
ax1.hist(result, bins=50, alpha=0.6)

plt.show()
plt.savefig("image2.png")

fig = plt.figure()
ax = fig.add_subplot(1, 1, 1)

comp1 = np.random.normal(0, 1, size=200)  # N(0,1)
comp2 = np.random.normal(10, 2, size=200)  # N(10,4)

values = Series(np.concatenate([comp1, comp2]))

print(values)

values.hist(bins=100, alpha=0.3, color='b', normed=True)
values.plot(kind='kde', style='r--')

plt.show()
plt.savefig("image3.png")
