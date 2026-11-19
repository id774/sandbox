#!/usr/bin/env python
# -*- coding: utf-8 -*-
# a_set.py: Set operations on the letters of two words
#
# Description:
# Apply union, intersection, difference, and symmetric difference to two sets.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 a_set.py
#
# Requirements:
# - Python 3
#

a = set("pecan")
b = set("pie")

print(a | b)
print(a & b)
print(a - b)
print(a ^ b)
