# ts.py: Time series indexed by datetime objects
#
# Description:
# Build a time series indexed by explicit datetime objects.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 ts.py
#
# Requirements:
# - Python 3
# - NumPy and pandas
#

import numpy as np
import pandas
from datetime import datetime

dates = [
    datetime(2014, 12, 1),
    datetime(2014, 12, 2),
    datetime(2014, 12, 3),
    datetime(2014, 12, 4),
    datetime(2014, 12, 5),
    datetime(2014, 12, 6)
]

ts = pandas.Series(np.random.randn(6), index=dates)

print(ts)
print(type(ts))
