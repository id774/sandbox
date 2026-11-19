#!/usr/bin/env python
# -*- coding: utf-8 -*-
# starred_arguments.py: Unpack a list into positional arguments
#
# Description:
# Unpack a list into positional arguments with the star operator.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 starred_arguments.py
#
# Requirements:
# - Python 3
#

def product(a, b, c):
    return a * b * c

if __name__ == '__main__':
    arr = [2, 3, 5]
    print(product(*arr))

    print(product(2, *arr[1:]))
