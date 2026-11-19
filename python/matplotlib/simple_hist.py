# -*- coding:utf-8 -*-
# simple_hist.py: Histogram with a title, grid, and axis labels
#
# Description:
# Draw a histogram with a title, grid, and axis labels.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 simple_hist.py
#
# Requirements:
# - Python 3
# - NumPy
# - Matplotlib before 3.1, which still provides matplotlib.mlab.normpdf
#

import numpy as np
import matplotlib.pyplot as plt
import matplotlib.mlab as mlab

x = np.array([236, 330, 375, 392, 460, 525, 578])
mu, sigma = 170, 5

plt.title("Test")
plt.grid(True)
plt.xlabel('X')
plt.ylabel('Y')

n, bins, patches = plt.hist(x, alpha=0.75, align='mid')
y = mlab.normpdf(bins, mu, sigma)
plt.plot(bins, y, 'r-', linewidth=1)

plt.show()
plt.savefig("image.png")
