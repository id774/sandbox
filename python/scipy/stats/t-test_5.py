# t-test_5.py: Paired t test on two small score sets
#
# Description:
# Run a paired t test on two small hand written score sets.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 t-test_5.py
#
# Requirements:
# - Python 3
# - SciPy
#

from scipy import stats

X = [68,75,80,71,73,79,69,65]
Y = [86,83,76,81,75,82,87,75]

print(X)
print(Y)

t, p = stats.ttest_rel(X, Y)

print( "t 値は %(t)s" %locals() )
print( "確率は %(p)s" %locals() )

if p < 0.05:
    print("有意な差があります")
else:
    print("有意な差がありません")

