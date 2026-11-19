#!/usr/bin/env python
# -*- coding: utf-8 -*-
# factorial.py: Recursive factorial with a doctest
#
# Description:
# Compute a factorial recursively. When run directly, the program executes the
# doctest in its module docstring and prints factorial(10). test_factorial.py
# also imports it.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 factorial.py
#
# Requirements:
# - Python 3
#

"""
>>> import factorial
>>> factorial.factorial(10)
3628800
"""

def factorial(n):
    if n == 1:
        return 1
    else:
        return n * factorial(n - 1)

if __name__ == '__main__':
    import doctest
    doctest.testmod()
    print(factorial(10))
