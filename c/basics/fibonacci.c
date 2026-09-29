/*
 * fibonacci.c: The first 20 Fibonacci numbers
 *
 * Description:
 * Print the first 20 Fibonacci numbers, carried in two unsigned long long locals.
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
 *     cc -o fibonacci fibonacci.c
 *     ./fibonacci
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

int main(void)
{
    unsigned long long current = 0;
    unsigned long long next = 1;

    for (int i = 0; i < 20; i++) {
        unsigned long long following;

        printf("%s%llu", i > 0 ? " " : "", current);
        following = current + next;
        current = next;
        next = following;
    }
    putchar('\n');
    return 0;
}
