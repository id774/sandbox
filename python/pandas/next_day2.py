# next_day2.py: Next business day from a two-period date range
#
# Description:
# Find the next business day with a two period date range.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 next_day2.py
#
# Requirements:
# - Python 3
# - pandas
#

import pandas as pd

s = pd.read_csv(
    "sampledata.csv",
    index_col=0, parse_dates=True)
print(s.index[-1])
index = pd.date_range(start=s.index[-1],
                      periods=2, freq='B')
ts = pd.Series(None, index=index)
print(ts.index[1])
