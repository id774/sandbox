# simple_plot.py: Cumulative random walks with different line styles
#
# Description:
# Plot several cumulative random walks with different line styles.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 simple_plot.py
#
# Requirements:
# - Python 3
# - NumPy and Matplotlib
#

import matplotlib.pyplot as plt
from numpy.random import randn

x1 = randn(50).cumsum()
x2 = randn(50).cumsum()
x3 = randn(50).cumsum()
x4 = randn(50).cumsum()

plt.figure()
plt.plot(x1, 'k--')
plt.plot(x2, 'r--')
plt.plot(x3, 'g--')
plt.plot(x4, 'b--')

plt.savefig('image.png')
