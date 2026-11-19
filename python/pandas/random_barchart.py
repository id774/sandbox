# random_barchart.py: Bar chart of a random Series
#
# Description:
# Plot a random Series as a bar chart.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 random_barchart.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, and Matplotlib
#

import numpy as np
import pandas as pd
import matplotlib.pyplot as plt

plt.figure()

data = pd.Series(np.random.randn(16), index=list('abcdefghijklmnop'))
print(data)
data.plot(kind='bar', color='k', alpha=0.7)

plt.show()
plt.savefig("image3.png")
