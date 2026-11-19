# uniq.py: Remove duplicates while preserving order
#
# Description:
# Remove duplicates from a list while preserving first appearance order.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 uniq.py
#
# Requirements:
# - Python 3
#

x = [3, 2, 1, 1]
ans = sorted(set(x), key=x.index)
print(ans)
