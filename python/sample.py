# sample.py: Call a small arithmetic function
#
# Description:
# Call a small arithmetic function with three arguments.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 sample.py
#
# Requirements:
# - Python 3
#

def f(x, y, z):
    return (x + y) / z

a = 5
b = 6
c = 7.5

print(f(a, b, c))
