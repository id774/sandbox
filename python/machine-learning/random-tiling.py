# -*- coding:utf-8 -*-
# random-tiling.py: Random matrix shown as a grayscale image
#
# Description:
# Display a random matrix as a grayscale image.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 random-tiling.py
#
# Requirements:
# - Python 3
# - NumPy and Matplotlib
#

import matplotlib.mlab as mlab
import matplotlib.pyplot as plt
import numpy as np

img = np.random.rand(32, 32)
plt.imshow(img)

plt.show()
plt.savefig("image.png")

plt.gray()

plt.show()
plt.savefig("image2.png")

plt.hot()

plt.show()
plt.savefig("image3.png")
