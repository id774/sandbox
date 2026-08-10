/* Multiply two fixed 3x3 integer matrices held as two dimensional arrays. */
/* Build: cc -o matrix matrix.c */

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
