#!/usr/bin/env python3
# modpow.py: Modular exponentiation of fixed triples by repeated squaring
#
# Description:
# Print modular powers of fixed triples, each squared and shifted down rather than left to pow.
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
#     python3 modpow.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

CASES = [(2, 1000, 1000003), (3, 200, 50), (5, 117, 19), (10, 18, 9999991)]


def modpow(base, exponent, modulus):
    result = 1
    base %= modulus
    while exponent:
        if exponent & 1:
            result = result * base % modulus
        base = base * base % modulus
        exponent >>= 1
    return result


for base, exponent, modulus in CASES:
    print(base, exponent, modulus, modpow(base, exponent, modulus))
