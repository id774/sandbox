# ndim.py: Dimensions and cumulative sums of NumPy arrays
#
# Description:
# Inspect the dimensions of numpy arrays and take cumulative sums.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 ndim.py
#
# Requirements:
# - Python 3
# - NumPy
#

import numpy as np

def cumsum(nparray):
    return nparray.cumsum()

a = np.array([
    [1, 2, 3],
    [4, 5, 6]
])

print(a.ndim)

b = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
])

print(b.ndim)

c = np.array([
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9],
    [10.11]
])

print(c.ndim)

d = np.array([
    [[1, 2, 3],
     [4, 5, 6]],
    [[7, 8, 9],
     [10.11, 12]],
    [13, 14, 15],
    [16, 17, 18]
])

print(d.ndim)
