#!/usr/bin/env python3
# pascal.py: The first 10 rows of Pascal's triangle
#
# Description:
# Print 10 rows of Pascal's triangle, each row zipped from the previous one shifted both ways.
#
# Part of the math cross-language exercise set: it reads no arguments or
# standard input, keeps its data fixed in the source, uses integer
# arithmetic only, and its output is the same as that of the same exercise
# in every other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 pascal.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

ROWS = 10

row = [1]
for _ in range(ROWS):
    print(" ".join(str(value) for value in row))
    row = [left + right for left, right in zip([0] + row, row + [0])]
