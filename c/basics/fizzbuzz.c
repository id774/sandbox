/*
 * fizzbuzz.c: FizzBuzz for 1 through 100
 *
 * Description:
 * Print FizzBuzz for 1 through 100.
 *
 * Part of the basics cross-language exercise set: the input is fixed in the
 * source, and the output is the same as that of the same exercise in every
 * other language. The exercises are specified in README.md at the
 * repository root.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o fizzbuzz fizzbuzz.c
 *     ./fizzbuzz
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

int main(void)
{
    for (int n = 1; n <= 100; n++) {
        if (n % 15 == 0)
            puts("FizzBuzz");
        else if (n % 3 == 0)
            puts("Fizz");
        else if (n % 5 == 0)
            puts("Buzz");
        else
            printf("%d\n", n);
    }
    return 0;
}
