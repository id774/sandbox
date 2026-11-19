# random_2f.py: Mean, median, variance, and deviation of random samples
#
# Description:
# Summarize random samples with mean, median, variance, and standard
# deviation.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 random_2f.py
#
# Requirements:
# - Python 3
# - NumPy
#

import numpy as np
import math

_seed1 = np.random.randint(low=420, high=680, size=100)
_seed2 = np.random.randint(low=380, high=540, size=100)

_m = _seed1 / 10
_f = _seed2 / 10

print(_m)
print(_f)

ave = np.average(_m)
med = np.median(_m)
var = np.var(_m)
std = np.std(_m)

print("平均値は %(ave)s" % locals())
print("中央値は %(med)s" % locals())
print("分散は %(var)s" % locals())
print("標準偏差は %(std)s" % locals())

ave = np.average(_f)
med = np.median(_f)
var = np.var(_f)
std = np.std(_f)

print("平均値は %(ave)s" % locals())
print("中央値は %(med)s" % locals())
print("分散は %(var)s" % locals())
print("標準偏差は %(std)s" % locals())
