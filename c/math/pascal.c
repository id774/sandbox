/*
 * pascal.c: The first 10 rows of Pascal's triangle
 *
 * Description:
 * Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end.
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
 *     cc -o pascal pascal.c
 *     ./pascal
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

#define ROWS 10

int main(void)
{
    int row[ROWS + 1] = {0};
    int length;

    row[0] = 1;

    for (length = 1; length <= ROWS; length++) {
        int i;

        for (i = 0; i < length; i++) {
            printf("%s%d", i > 0 ? " " : "", row[i]);
        }
        putchar('\n');

        for (i = length; i > 0; i--) {
            row[i] += row[i - 1];
        }
    }
    return 0;
}
