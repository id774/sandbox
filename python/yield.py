#!/usr/bin/env python
# -*- coding: utf-8 -*-
# yield.py: Generate values with yield
#
# Description:
# Produce a sequence of values from a generator function with yield.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 yield.py
#
# Requirements:
# - Python 3
#

def yieldtest():
    for i in range(10):
        yield (10 + i)

if __name__ == '__main__':
    for j in yieldtest():
        print(j)
