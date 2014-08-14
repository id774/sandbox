# -*- coding: utf-8 -*-

import numpy as np
import scipy as sp
from scipy import stats

rvs1 = sp.array([
    32.97, 36.37, 35.24, 36.03, 34.84, 33.63, 37.94, 33.48, 34.09, 33.74,
    34.53, 36.86, 31.79, 35.61, 34.14, 34.51, 35.13, 32.83, 34.89, 32.19,
    36.67, 36.01, 37.04, 35.1, 33.73
])
rvs2 = stats.norm.rvs(loc=35.3, scale=0.925, size=25)

print(rvs1)
print(rvs2)
rvs1ave = np.average(rvs1)
rvs2ave = np.average(rvs2)
print("rvs1 の平均は %(rvs1ave)s" % locals())
print("rvs2 の平均は %(rvs2ave)s" % locals())

t, p = stats.ttest_rel(rvs1, rvs2)

print("t 値は %(t)s" % locals())
print("確率は %(p)s" % locals())

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")
