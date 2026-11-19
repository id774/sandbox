# defaults.py: Cosine and sine with the Matplotlib defaults
#
# Description:
# Plot cosine and sine with the matplotlib defaults.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 defaults.py
#
# Requirements:
# - Python 3
# - Matplotlib with pylab
#

from pylab import *
import matplotlib.pyplot as plt

X = np.linspace(-np.pi, np.pi, 256, endpoint=True)
C, S = np.cos(X), np.sin(X)

plt.plot(X, C)
plt.plot(X, S)
plt.show()
plt.savefig("image.png")
