/* Print the primes below 100, sieved over a fixed array of flags on the stack. */
/* Build: cc -o sieve sieve.c */

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
