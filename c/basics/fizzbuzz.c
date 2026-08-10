/* Print FizzBuzz for 1 through 100. */
/* Build: cc -o fizzbuzz fizzbuzz.c */

#include <stdio.h>

int main(void)
{
    for (int n = 1; n <= 100; n++) {
        if (n % 15 == 0)
            puts("FizzBuzz");
        else if (n % 3 == 0)
            puts("Fizz");
        else if (n % 5 == 0)
            puts("Buzz");
        else
            printf("%d\n", n);
    }
    return 0;
}
