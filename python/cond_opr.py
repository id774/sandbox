# cond_opr.py: Select a value with the conditional expression
#
# Description:
# Select a value with the conditional expression operator.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 cond_opr.py
#
# Requirements:
# - Python 3
#

x = ""
value = "hoge"
value2 = "fuga"

condition = True
x = value if condition else value2
print(x)

condition = False
x = value if condition else value2
print(x)
