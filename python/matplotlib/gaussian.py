# -*- coding:utf-8 -*-
# gaussian.py: Gaussian process regression of a noisy sine
#
# Description:
# Fit a noisy sine with Gaussian process regression and plot the result.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 gaussian.py
#
# Requirements:
# - Python 3
# - NumPy, scikit-learn, and Matplotlib
#

import numpy as np
import matplotlib.pyplot as plt

# Sample x at random and generate y = sin(x) + noise to match
np.random.seed(1)
x = np.sort(np.random.uniform(-np.pi, np.pi, 100))
y = np.sin(x) + 0.1 * np.random.normal(size=len(x))

# Reshape into the format scikit-learn expects
x = x.reshape((len(x), 1))

# Plot all of the data
plt.plot(x, y, 'o')
plt.show()
plt.savefig("image.png")
