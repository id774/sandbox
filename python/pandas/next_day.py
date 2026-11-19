# next_day.py: Next business day after a CSV time series
#
# Description:
# Find the next business day after the last row of a CSV time series.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 next_day.py
#
# Requirements:
# - Python 3
# - pandas
# - sampledata.csv in the current directory
#

import pandas as pd
import datetime

s = pd.read_csv(
    "sampledata.csv",
    index_col=0, parse_dates=True)
print(s.index[-1])
period_day = s.index[-1] + datetime.timedelta(days=1)
index = pd.date_range(start=period_day,
                      periods=1, freq='B')
ts = pd.Series(None, index=index)
print(ts.index[0])
