# demo3.py: chi2_contingency test of a DataFrame table
#
# Description:
# Test a contingency table held in a DataFrame with chi2_contingency.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 demo3.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, and Matplotlib
# - SciPy from a release whose top-level namespace still provides NumPy
#   aliases such as scipy.array
#

import numpy as np
import scipy as sp
import pandas as pd
import matplotlib.pyplot as plt
from scipy import stats

arr = sp.array([[435, 265],
                [165, 135]])
df = pd.DataFrame(arr)

x2, p, dof, expected = stats.chi2_contingency(df)
print(p)
