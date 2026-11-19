# ewma.py: Exponentially weighted moving average of a triangular series
#
# Description:
# Plot an exponentially weighted moving average over a triangular series.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 ewma.py
#
# Requirements:
# - Python 3
# - NumPy and Matplotlib
# - pandas before 0.23, which still provides pd.stats.moments.ewma
#

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

ewma = pd.stats.moments.ewma

x = list(range(1, 50)) + list(range(50, 0, -1))
ma = ewma(np.array(x), span=15)

plt.plot(x, linewidth=1.0)
plt.plot(ma, linewidth=1.0)

plt.show()
plt.savefig("image.png")
