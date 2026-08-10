/* Print 10 rows of Pascal's triangle, each row rewritten in place from its right hand end. */
/* Build: cc -o pascal pascal.c */

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
