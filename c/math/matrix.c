/*
 * matrix.c: Product and determinant of two fixed 3x3 integer matrices
 *
 * Description:
 * Multiply two fixed 3x3 integer matrices held as two dimensional arrays.
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
 *     cc -o matrix matrix.c
 *     ./matrix
 *
 * Requirements:
 * - A C99 compiler run as cc, such as GCC 5 or later or Clang 3.6
 *   or later
 * - No third-party package is required
 */

#include <stdio.h>

#define SIZE 3

static void multiply(const int left[SIZE][SIZE], const int right[SIZE][SIZE], int product[SIZE][SIZE])
{
    int i, j, k;

    for (i = 0; i < SIZE; i++) {
        for (j = 0; j < SIZE; j++) {
            product[i][j] = 0;
            for (k = 0; k < SIZE; k++) {
                product[i][j] += left[i][k] * right[k][j];
            }
        }
    }
}

static int determinant(const int m[SIZE][SIZE])
{
    return m[0][0] * (m[1][1] * m[2][2] - m[1][2] * m[2][1])
         - m[0][1] * (m[1][0] * m[2][2] - m[1][2] * m[2][0])
         + m[0][2] * (m[1][0] * m[2][1] - m[1][1] * m[2][0]);
}

int main(void)
{
    static const int left[SIZE][SIZE] = {{2, -1, 0}, {1, 3, 4}, {0, 5, -2}};
    static const int right[SIZE][SIZE] = {{1, 0, 2}, {-3, 1, 1}, {4, 2, 0}};
    int product[SIZE][SIZE];
    int i, j;

    multiply(left, right, product);

    for (i = 0; i < SIZE; i++) {
        for (j = 0; j < SIZE; j++) {
            printf("%s%d", j > 0 ? " " : "", product[i][j]);
        }
        putchar('\n');
    }
    printf("%d\n", determinant(product));
    return 0;
}
