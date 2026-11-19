/*
 * GHOST.c: Detect the GHOST glibc gethostbyname_r overflow
 *
 * Description:
 * Detect the GHOST gethostbyname_r buffer overflow in glibc (CVE-2015-0235).
 * It calls gethostbyname_r with a name sized to reach a canary placed after
 * the buffer, then prints "vulnerable" when the canary was overwritten, "not
 * vulnerable" when the call returned ERANGE, and "should not happen"
 * otherwise.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o GHOST GHOST.c
 *     ./GHOST
 *
 * Requirements:
 * - A C compiler such as GCC or Clang
 * - The GNU C Library (glibc), whose gethostbyname_r is the function under
 *   test
 */

#include <netdb.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <errno.h>

#define CANARY "in_the_coal_mine"

struct {
  char buffer[1024];
  char canary[sizeof(CANARY)];
} temp = { "buffer", CANARY };

int main(void) {
  struct hostent resbuf;
  struct hostent *result;
  int herrno;
  int retval;

  /*** strlen (name) = size_needed - sizeof (*host_addr) - sizeof (*h_addr_ptrs) - 1; ***/
  size_t len = sizeof(temp.buffer) - 16*sizeof(unsigned char) - 2*sizeof(char *) - 1;
  char name[sizeof(temp.buffer)];
  memset(name, '0', len);
  name[len] = '\0';

  retval = gethostbyname_r(name, &resbuf, temp.buffer, sizeof(temp.buffer), &result, &herrno);

  if (strcmp(temp.canary, CANARY) != 0) {
    puts("vulnerable");
    exit(EXIT_SUCCESS);
  }
  if (retval == ERANGE) {
    puts("not vulnerable");
    exit(EXIT_SUCCESS);
  }
  puts("should not happen");
  exit(EXIT_FAILURE);
}
