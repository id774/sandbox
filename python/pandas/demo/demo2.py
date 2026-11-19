# demo2.py: Scatter and test two score sets in a DataFrame
#
# Description:
# Hold two score sets in a DataFrame, scatter them, and test their
# relationship.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 demo2.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, SciPy, and Matplotlib
#

import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats

X = [68, 75, 80, 71, 73, 79, 69, 65]
Y = [86, 83, 76, 81, 75, 82, 87, 75]

df = pd.DataFrame({'X': X, 'Y': Y})

plt.figure()
plt.scatter(X, Y)

print(df.corr())
print(stats.ttest_rel(X, Y))
