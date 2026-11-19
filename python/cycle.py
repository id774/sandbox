# cycle.py: Pair a numeric range with a cycling letter sequence
#
# Description:
# Pair a numeric range with an endlessly cycling sequence of letters.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 cycle.py
#
# Requirements:
# - Python 3
# - NumPy
#

from itertools import cycle
import numpy as np
c = cycle('ABCDEFGH')
lis = np.arange(0, 100)

for i, c in zip(lis, c):
    print(i, c)
