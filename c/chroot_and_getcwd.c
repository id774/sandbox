/*
 * chroot_and_getcwd.c: Print the working directory around a chroot call
 *
 * Description:
 * Print the working directory before and after calling chroot. The program
 * changes its root to /var/empty and shows how getcwd reports the unchanged
 * working directory afterward. It prints the errno value and exits with status
 * 1 when getcwd or chroot fails.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o chroot_and_getcwd chroot_and_getcwd.c
 *     sudo ./chroot_and_getcwd
 *
 * Requirements:
 * - A C compiler such as GCC or Clang
 * - A Unix-like system that provides chroot and an existing /var/empty
 *   directory
 * - Root privilege, which chroot requires
 */

#include <stdio.h>
#include <unistd.h>
#include <errno.h>
#define BUFMAX 256

int main(int argc, char *argv[]) {
  char buf[BUFMAX];
  if (!getcwd(buf, BUFMAX)) {
    printf("Can't getcwd errno=%d\n", errno);
    return 1;
  }

  printf("cwd=%s\n", buf);
  if (chroot("/var/empty") < 0) {
    printf("Can't chroot errno=%d\n", errno);
    return 1;
  }

  if (!getcwd(buf, BUFMAX)) {
    printf("Can't getcwd errno=%d\n", errno);
    return 1;
  }

  printf("cwd=%s\n", buf);

  return 0;
}
