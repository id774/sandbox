# dis_example2.py: Disassemble a list comprehension and a map and filter chain
#
# Description:
# Disassemble a list comprehension against an equivalent map and filter chain.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 dis_example2.py
#
# Requirements:
# - Python 3
# - NumPy
#

from dis import dis
import numpy as np

def list_comprehensions(ary=np.arange(1, 10)):
    return [x * 2 for x in ary if x % 2 == 1]

def map_and_filter(ary=np.arange(1, 10)):
    return map(lambda x: x * 2, filter(lambda x: x % 2 == 1, ary))

print(list_comprehensions())
dis(list_comprehensions)
print(map_and_filter())
dis(map_and_filter)
