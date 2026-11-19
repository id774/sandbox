#!/usr/bin/env python
# -*- coding: utf-8 -*-
# lambda2.py: Compare a named area function with a lambda
#
# Description:
# Compare a named area function with the same logic written as a lambda.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 lambda2.py
#
# Requirements:
# - Python 3
#

def area(b, h):
    return 0.5 * b * h

print(area(10, 4))

area2 = lambda b, h: 0.5 * b * h

print(area2(10, 4))
