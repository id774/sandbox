/*
 * msrand.c: Random bits from a minimal standard generator
 *
 * Description:
 * Generate random bits with a minimal standard linear congruential generator.
 * The Park-Miller generator uses Schrage's method with a fixed seed of 1, and
 * the program prints 1024 lines of 0 or 1 according to whether each value is
 * below 0.5.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o msrand msrand.c
 *     ./msrand
 *
 * Requirements:
 * - A C compiler that accepts the pre-C99 implicit int declaration of a
 *   static variable
 */

#include <stdio.h>

#define IA 16807
#define IM 2147483647
#define AM (1.0/IM)
#define IQ 127773
#define IR 2836
#define SEED 1

#define IMAX 1024

double ran()
{
    static b = SEED;
    long k;
    double ans;

    k=b/IQ;
    b=IA*(b-k*IQ)-IR*k;
    if (b<0) b += IM;
    ans=AM*b;

    return ans;
}

int main(void)
{
    int i, r;

    for(i=0; i<IMAX; i++) {
        if(ran()<0.5) r=0; else r=1;
        printf("%d\n",r);
    }

    return 0;
}
