/* Print the divisor and multiple of fixed pairs, with Euclid's algorithm run in a while loop. */
/* Build: cc -o gcd_lcm gcd_lcm.c */

#include <stdio.h>

static long gcd(long first, long second)
{
    while (second != 0) {
        long remainder = first % second;

        first = second;
        second = remainder;
    }
    return first;
}

int main(void)
{
    static const long pairs[][2] = {{1071, 462}, {270, 192}, {17, 5}, {120, 36}};
    size_t i;

    for (i = 0; i < sizeof pairs / sizeof pairs[0]; i++) {
        long first = pairs[i][0];
        long second = pairs[i][1];
        long divisor = gcd(first, second);

        printf("%ld %ld %ld %ld\n", first, second, divisor, first / divisor * second);
    }
    return 0;
}
