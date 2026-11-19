# zscore.py: Hand written z score against scipy.stats.zscore
#
# Description:
# Compare a hand written z score with scipy.stats.zscore on a pandas Series.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 zscore.py
#
# Requirements:
# - Python 3
# - NumPy, pandas, and SciPy
#

import numpy as np
import pandas as pd
from scipy import stats

def calc_zscore(data):
    return (data - data.mean()) / data.std()

def calc_zscore_stats(data):
    return stats.zscore(data)

def main():
    M = 100
    data = pd.Series(np.random.randn(M))
    result = calc_zscore(data)
    print(result.describe())
    result = calc_zscore_stats(data)
    result = pd.Series(result)
    print(result.describe())

if __name__ == '__main__':
    main()
