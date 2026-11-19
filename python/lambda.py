#!/usr/bin/env python
# -*- coding: utf-8 -*-
# lambda.py: Compare a named cube function with a lambda
#
# Description:
# Compare a named cube function with the same logic written as a lambda.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 lambda.py
#
# Requirements:
# - Python 3
#

def f(x):
    return x ** 3

def closure(x):
    y = lambda x: x ** 3
    return (y(x))

if __name__ == '__main__':
    x = 5
    print(f(x))
    print(closure(x))
