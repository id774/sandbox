/*
 * hoge.c: Print the truncated result of integer division
 *
 * Description:
 * Print the truncated result of integer division, 5 / 2, which is 2.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o hoge hoge.c
 *     ./hoge
 *
 * Requirements:
 * - A C compiler that accepts the pre-C99 implicit int return type of main
 */

#include <stdio.h>

main()
{
  int a = 5;
  int b = 2;
  int c = a / b;
  printf("%d\n", c);
}
