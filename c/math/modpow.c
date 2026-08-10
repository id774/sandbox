/* Print modular powers of fixed triples, each squared and halved by repeated squaring. */
/* Build: cc -o modpow modpow.c */

#include <stdio.h>

static long long modpow(long long base, long long exponent, long long modulus)
{
    long long result = 1;

    base %= modulus;
    while (exponent > 0) {
        if (exponent % 2 == 1) {
            result = result * base % modulus;
        }
        base = base * base % modulus;
        exponent /= 2;
    }
    return result;
}

int main(void)
{
    static const long long cases[][3] = {
        {2, 1000, 1000003}, {3, 200, 50}, {5, 117, 19}, {10, 18, 9999991}
    };
    size_t i;

    for (i = 0; i < sizeof cases / sizeof cases[0]; i++) {
        long long base = cases[i][0];
        long long exponent = cases[i][1];
        long long modulus = cases[i][2];

        printf("%lld %lld %lld %lld\n", base, exponent, modulus, modpow(base, exponent, modulus));
    }
    return 0;
}
