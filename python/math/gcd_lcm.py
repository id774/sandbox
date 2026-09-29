#!/usr/bin/env python3
# gcd_lcm.py: GCD and LCM of fixed pairs by Euclid's algorithm
#
# Description:
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.
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
#     python3 gcd_lcm.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

PAIRS = [(1071, 462), (270, 192), (17, 5), (120, 36)]


def gcd(a, b):
    while b:
        a, b = b, a % b
    return a


for first, second in PAIRS:
    divisor = gcd(first, second)
    print(first, second, divisor, first // divisor * second)
