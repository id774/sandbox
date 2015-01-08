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
