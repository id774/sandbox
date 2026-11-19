# gradf.py: Gradient descent on a quadratic function
#
# Description:
# Minimize a quadratic function by gradient descent.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 gradf.py
#
# Requirements:
# - Python 3
#

x = 0
y = 0
l = 0.1
for i in range(400):
    if (i % 10 == 0):
        print("step:{0} (x,y)=({1:.5f},{2:.5f}) f(x,y)={3:.5f}"
              .format(i, x, y, x * x - 4 * x * y + 5 * y * y - 2 * y + 2))
    newx = x - l * (2 * x - 4 * y)
    newy = y - l * (-4 * x + 10 * y - 2)
    x = newx
    y = newy
