#!/usr/bin/env python
# - * - coding: utf-8 - * -
# complete.py: Perfect numbers from proper divisor sums
#
# Description:
# Find perfect numbers by summing their proper divisors.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 complete.py
#
# Requirements:
# - Python 3
#

try:
    xrange
except:
    xrange = range

def get_divisor(number):
    l = []
    for cnt in range(1, number):
        if number % (cnt) == 0:
            l.append(cnt)
    return l

def is_complete(number):
    multi = 0
    for num in get_divisor(number):
        multi += num
    if multi == number:
        return True
    else:
        return False

if __name__ == "__main__":
    #import doctest
    # doctest.testmod()
    for cnt in xrange(1, 1001):
        if is_complete(cnt):
            print(cnt)
