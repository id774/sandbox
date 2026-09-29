/*
 * gcd_lcm.c: GCD and LCM of fixed pairs by Euclid's algorithm
 *
 * Description:
 * Print the divisor and multiple of fixed pairs, with Euclid's algorithm run in a while loop.
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
 *     cc -o gcd_lcm gcd_lcm.c
 *     ./gcd_lcm
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

static long gcd(long first, long second)
{
    while (second != 0) {
        long remainder = first % second;

        first = second;
        second = remainder;
    }
    return first;
}

int main(void)
{
    static const long pairs[][2] = {{1071, 462}, {270, 192}, {17, 5}, {120, 36}};
    size_t i;

    for (i = 0; i < sizeof pairs / sizeof pairs[0]; i++) {
        long first = pairs[i][0];
        long second = pairs[i][1];
        long divisor = gcd(first, second);

        printf("%ld %ld %ld %ld\n", first, second, divisor, first / divisor * second);
    }
    return 0;
}
