# fisher.py: Fisher's exact test on a two by two table
#
# Description:
# Run Fisher's exact test on a two by two contingency table.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 fisher.py
#
# Requirements:
# - Python 3
# - SciPy
#

from scipy import stats

oddsratio, pvalue = stats.fisher_exact([[167, 133], [185, 115]])
print(oddsratio, pvalue)
