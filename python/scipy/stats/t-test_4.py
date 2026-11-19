# -*- coding: utf-8 -*-
# t-test_4.py: Scatter plot and paired t test of two samples
#
# Description:
# Scatter plot two samples and run a paired t test on them.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 t-test_4.py
#
# Requirements:
# - Python 3
# - Matplotlib
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.array
#

import scipy as sp
from scipy import stats
import matplotlib.pyplot as plt

x = sp.array([
    32.97, 36.37, 35.24, 36.03, 34.84, 33.63, 37.94, 33.48, 34.09, 33.74,
    34.53, 36.86, 31.79, 35.61, 34.14, 34.51, 35.13, 32.83, 34.89, 32.19,
    36.67, 36.01, 37.04, 35.1, 33.73
])
y = stats.norm.rvs(loc=35.3, scale=0.925, size=25)

plt.figure()
plt.scatter(x, y)
plt.savefig('image.png')

t, p = stats.ttest_rel(x, y)

print("t 値は %(t)s" % locals())
print("確率は %(p)s" % locals())

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")
