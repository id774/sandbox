# multiple-regression2.py: Reusable least squares multiple regression
#
# Description:
# Wrap the least squares multiple regression in a reusable function.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 multiple-regression2.py
#
# Requirements:
# - Python 3
# - NumPy and SciPy
#

import numpy as np
from scipy import linalg

x = [15, 5]
y = [-10, -20]
z = [30, 45]

print("x", x)
print("y", y)
print("z", z)

def multi_regression(x, y, z):
    N = len(x)
    G = np.array([x, y, np.ones(N)]).T
    result = linalg.solve(G.T.dot(G), G.T.dot(z))
    return result

result = multi_regression(x, y, z)
print("result", result)
