#!/usr/bin/env python
# boxplot4.py: Box plots of three Poisson samples in pandas Series
#
# Description:
# Draw box plots of three Poisson samples held in pandas Series.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 boxplot4.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, and Matplotlib
#

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
