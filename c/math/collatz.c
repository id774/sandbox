/* Print the start below 1000 with the longest Collatz sequence, tracked in a running maximum. */
/* Build: cc -o collatz collatz.c */

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
