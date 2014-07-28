#!/usr/bin/env python
import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

s1 = pd.Series(np.random.poisson(5, 10000))
s1.describe()
s2 = pd.Series(np.random.poisson(10, 10000))
s3 = pd.Series(np.random.poisson(20, 10000))

fig = plt.figure()
ax = fig.add_subplot(111)
ax.boxplot([s1, s2, s3])

xticks = ['A', 'B', 'C', ]
plt.xticks([1, 2, 3], xticks)
plt.grid()
plt.ylabel('Length')
plt.xlabel('type')

#s0 = pd.Series([0] * len(s1))
ax.plot([s1, s2, s3], marker='.', linestyle='None', )

plt.show()
plt.savefig("image.png")

