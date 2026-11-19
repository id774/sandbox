# cumsum.py: Cumulative sums over two-dimensional arrays
#
# Description:
# Take cumulative sums over two dimensional numpy arrays.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 cumsum.py
#
# Requirements:
# - Python 3
# - NumPy and SciPy
#

import numpy as np
import scipy as sp

def cumsum(nparray):
    return nparray.cumsum()

a = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

print(a)
print(np.cumsum(a))

b = np.array([
    [2, 4, 6],
    [8, 10, 12]
])

print(b)
print(np.cumsum(b))

print(np.cumsum(a, axis=0))
print(np.cumsum(a, axis=1))
