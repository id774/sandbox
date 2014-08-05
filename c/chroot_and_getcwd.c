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
