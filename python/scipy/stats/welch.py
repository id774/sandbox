# welch.py: Student's t test against Welch's t test
#
# Description:
# Compare Student's t test with Welch's t test on samples of unequal variance.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 welch.py
#
# Requirements:
# - Python 3
# - NumPy and SciPy
#

from scipy import stats
import numpy as np
np.random.seed(12345678)

rvs1 = stats.norm.rvs(loc=5, scale=10, size=500)
rvs2 = stats.norm.rvs(loc=5, scale=20, size=100)

result = stats.ttest_ind(rvs1, rvs2)
print(result)

result = stats.ttest_ind(rvs1, rvs2, equal_var=False)
print(result)

rvs3 = stats.norm.rvs(loc=8, scale=20, size=100)

result = stats.ttest_ind(rvs1, rvs3, equal_var=False)
print(result)
