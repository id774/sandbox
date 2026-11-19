/*
 * unixtime.c: Show ctime output for time_t boundary values
 *
 * Description:
 * Print how ctime renders notable time_t boundary values: 0, the current time,
 * 0x7fffffff, 0x80000000, and 0xffffffff, each beside its hexadecimal value.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o unixtime unixtime.c
 *     ./unixtime
 *
 * Requirements:
 * - A C compiler such as GCC or Clang
 */

#include <stdio.h>
#include <time.h>

int main()
{
    time_t t;

    t = 0;
    printf("0x%08x: %s", (unsigned)t, ctime(&t));
    t = time(NULL);
    printf("0x%08x: %s", (unsigned)t, ctime(&t));
    t = 0x7fffffff;
    printf("0x%08x: %s", (unsigned)t, ctime(&t));
    t = 0x80000000;
    printf("0x%08x: %s", (unsigned)t, ctime(&t));
    t = 0xffffffff;
    printf("0x%08x: %s", (unsigned)t, ctime(&t));
    return 0;
}
