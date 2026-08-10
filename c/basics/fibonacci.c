/* Print the first 20 Fibonacci numbers, carried in two unsigned long long locals. */
/* Build: cc -o fibonacci fibonacci.c */

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
