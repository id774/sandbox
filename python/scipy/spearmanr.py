# spearmanr.py: Spearman rank correlation of random integer pairs
#
# Description:
# Compute the Spearman rank correlation of random integer pairs.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 spearmanr.py
#
# Requirements:
# - Python 3
# - NumPy and SciPy
#

import numpy as np
from scipy.stats import spearmanr

xint = np.random.randint(10, size=(100, 2))
print(spearmanr(xint))
