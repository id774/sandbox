# fill_demo.py: Fill the area under a damped sine curve
#
# Description:
# Fill the area under a damped sine curve.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 fill_demo.py
#
# Requirements:
# - Python 3
# - NumPy and Matplotlib
#

import numpy as np
import matplotlib.pyplot as plt


x = np.linspace(0, 1)
y = np.sin(4 * np.pi * x) * np.exp(-5 * x)

plt.fill(x, y, 'r')
plt.grid(True)
plt.show()
plt.savefig('image.png')
