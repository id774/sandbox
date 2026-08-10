#!/usr/bin/env python3
# Print modular powers of fixed triples, each squared and shifted down rather than left to pow.

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
