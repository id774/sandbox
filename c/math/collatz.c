/*
 * collatz.c: Longest Collatz sequence for a start below 1000
 *
 * Description:
 * Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum.
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
 *     cc -o collatz collatz.c
 *     ./collatz
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

#define LIMIT 1000

static int chain_length(long start)
{
    int length = 1;

    while (start != 1) {
        start = start % 2 == 0 ? start / 2 : start * 3 + 1;
        length++;
    }
    return length;
}

int main(void)
{
    int longest = 1;
    int best = 1;
    int start;

    for (start = 1; start < LIMIT; start++) {
        int length = chain_length(start);

        if (length > best) {
            longest = start;
            best = length;
        }
    }
    printf("%d %d\n", longest, best);
    return 0;
}
