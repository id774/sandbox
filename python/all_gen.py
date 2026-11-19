# all_gen.py: Short-circuit behavior of all() over a list and a generator
#
# Description:
# Compare how all() short circuits over a list comprehension and a generator.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 all_gen.py
#
# Requirements:
# - Python 3
#

def x(n):
    print(n)
    return n

r = all([x(n) < 3 for n in range(5)])
print(r)

r = all(x(n) < 3 for n in range(5))
print(r)
