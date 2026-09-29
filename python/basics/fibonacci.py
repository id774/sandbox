#!/usr/bin/env python3
# fibonacci.py: The first 20 Fibonacci numbers
#
# Description:
# Print the first 20 Fibonacci numbers from a generator.
#
# Part of the basics cross-language exercise set: the input is fixed in the
# source, and the output is the same as that of the same exercise in every
# other language. The exercises are specified in README.md at the
# repository root.
#
# Author: id774 (More info: https://id774.net)
# Source Code: https://github.com/id774/sandbox
# License: The GPL version 3, or LGPL version 3 (Dual License).
# Contact: idnanashi@gmail.com
#
# Usage:
#     python3 fibonacci.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

from itertools import islice


def fibonacci():
    current, following = 0, 1
    while True:
        yield current
        current, following = following, current + following


print(" ".join(str(value) for value in islice(fibonacci(), 20)))
