/*
 * sieve.c: Primes below 100 by the sieve of Eratosthenes
 *
 * Description:
 * Print the primes below 100, sieved over a fixed array of flags on the stack.
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
 *     cc -o sieve sieve.c
 *     ./sieve
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

#define LIMIT 100

int main(void)
{
    int is_prime[LIMIT];
    int n;
    int first = 1;

    for (n = 0; n < LIMIT; n++) {
        is_prime[n] = n >= 2;
    }

    for (n = 2; n * n < LIMIT; n++) {
        if (is_prime[n]) {
            int multiple;

            for (multiple = n * n; multiple < LIMIT; multiple += n) {
                is_prime[multiple] = 0;
            }
        }
    }

    for (n = 0; n < LIMIT; n++) {
        if (is_prime[n]) {
            printf("%s%d", first ? "" : " ", n);
            first = 0;
        }
    }
    putchar('\n');
    return 0;
}
