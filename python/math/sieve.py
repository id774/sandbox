#!/usr/bin/env python3
# sieve.py: Primes below 100 by the sieve of Eratosthenes
#
# Description:
# Print the primes below 100, sieved by striking out multiples with slice assignment.
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
#     python3 sieve.py
#
# Requirements:
# - Python 3.10 or later
# - No third-party package is required

LIMIT = 100

is_prime = [True] * LIMIT
is_prime[0] = is_prime[1] = False

for n in range(2, int(LIMIT ** 0.5) + 1):
    if is_prime[n]:
        multiples = is_prime[n * n::n]
        is_prime[n * n::n] = [False] * len(multiples)

print(" ".join(str(n) for n, prime in enumerate(is_prime) if prime))
