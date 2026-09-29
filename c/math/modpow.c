/*
 * modpow.c: Modular exponentiation of fixed triples by repeated squaring
 *
 * Description:
 * Print modular powers of fixed triples, each squared and halved by repeated squaring.
 *
 * Part of the math cross-language exercise set: it reads no arguments or
 * standard input, keeps its data fixed in the source, uses integer
 * arithmetic only, and its output is the same as that of the same exercise
 * in every other language. The exercises are specified in README.md at the
 * repository root.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o modpow modpow.c
 *     ./modpow
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

static long long modpow(long long base, long long exponent, long long modulus)
{
    long long result = 1;

    base %= modulus;
    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = result * base % modulus;
        }
        base = base * base % modulus;
        exponent /= 2;
    }
    return result;
}

int main(void)
{
    static const long long cases[][3] = {
        {2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}
    };
    size_t i;

    for (i = 0; i < sizeof cases / sizeof cases[0]; i++) {
        long long base = cases[i][0];
        long long exponent = cases[i][1];
        long long modulus = cases[i][2];

        printf("%lld %lld %lld %lld\n", base, exponent, modulus, modpow(base, exponent, modulus));
    }
    return 0;
}
