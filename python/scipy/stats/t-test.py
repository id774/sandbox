# t-test.py: Paired t test on random integer samples
#
# Description:
# Run a paired t test on two random integer samples.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 t-test.py
#
# Requirements:
# - Python 3
# - NumPy and SciPy
#

import numpy as np
import scipy as sp
from scipy import stats

X = np.random.randint(65, 90, size=8)
Y = np.random.randint(75, 95, size=8)

print(X)
print(Y)

t, p = stats.ttest_rel(X, Y)

print("t 値は %(t)s" % locals())
print("確率は %(p)s" % locals())

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")
