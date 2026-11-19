/*
 * fizzbuzz.c: Print FizzBuzz for 0 through 100
 *
 * Description:
 * Print FizzBuzz for 0 through 100, writing Fizz for multiples of 3, Buzz for
 * multiples of 5, and the number otherwise.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o fizzbuzz fizzbuzz.c
 *     ./fizzbuzz
 *
 * Requirements:
 * - A C compiler such as GCC or Clang
 */

#include <stdio.h>

int main() {
  int i;
  for(i=0;i <= 100;i++) {
    if((i % 3) == 0) {
      printf("Fizz");
    }
    if((i % 5) == 0) {
      printf("Buzz");
    }
    if((i % 5) != 0 && (i % 3) != 0) {
      printf("%d",i);
    }
    printf("\n");
  }
  return 0;
}
