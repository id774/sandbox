#!/usr/bin/env python3
# Print the divisor and multiple of fixed pairs, with Euclid's algorithm run on a tuple swap.

PAIRS = [(1071, 462), (270, 192), (17, 5), (120, 36)]


def gcd(a, b):
    while b:
        a, b = b, a % b
    return a


for first, second in PAIRS:
    divisor = gcd(first, second)
    print(first, second, divisor, first // divisor * second)
