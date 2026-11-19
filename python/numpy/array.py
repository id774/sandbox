# array.py: Build NumPy arrays in several ways
#
# Description:
# Build numpy arrays with array, arange, linspace, and loadtxt.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 array.py
#
# Requirements:
# - Python 3
# - NumPy
#

from numpy import *

a = array([1, 2, 3])
print(a)

f = array([1, 2, 3], dtype=float)
print(f)

a = arange(0, 10, 0.1)
print(a)

a = linspace(0, 2, 20)
print(a)
print(len(a))

data = loadtxt("data.txt")
print(data)
print(data[1, :])
print(data[:, 1])
