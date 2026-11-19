# simple_plot.py: Cosine and sine curves saved as images
#
# Description:
# Plot cosine and sine curves and save them as images.
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

import numpy as np
import matplotlib.pyplot as plt

x = np.arange(0, 10, 0.1)
y = np.cos(x)
plt.figure()
plt.plot(x, y, 'o')
plt.show()
plt.savefig("image.png")

x = np.arange(0, 5, 0.1)
y = np.sin(x)
plt.figure()
plt.plot(x, y, 'o')
plt.show()
plt.savefig("image2.png")
