#!/usr/bin/env python3
# collatz.py: Longest Collatz sequence for a start below 1000
#
# Description:
# Print the start below 1000 with the longest Collatz sequence, found by max over a key function.
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
#     python3 collatz.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

LIMIT = 1000


def chain_length(start):
    value = start
    length = 1
    while value != 1:
        value = value // 2 if value % 2 == 0 else 3 * value + 1
        length += 1
    return length


longest = max(range(1, LIMIT), key=chain_length)
print(longest, chain_length(longest))
