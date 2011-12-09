#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
 
int main()
{
    int s, s2, len;
    struct sockaddr_in local, client;
    char str[BUFSIZ];
 
    if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket");
        exit(1);
    }

    memset((char *)&local, 0, sizeof(local));
    local.sin_family = PF_INET;
    local.sin_addr.s_addr  = htonl(INADDR_ANY);
    local.sin_port = htons(3000);
    if (bind(s, (struct sockaddr *)&local, sizeof(local)) < 0) {
        perror("bind");
        exit(1);
    }

    if (listen(s, 5) < 0) {
        perror("listen");
        exit(1);
    }

    for(;;) {
        printf("Waiting for a connection...\n");
        memset((char *)&client, 0, sizeof(client));
        len = sizeof(client);
        if ((s2 = accept(s, (struct sockaddr *)&client, &len)) < 0) {
            perror("accept");
            exit(1);
        }

        printf("Connected.\n");

        do {
            int n;
            n = recv(s2, str, BUFSIZ, 0);
            if (n <= 0) {
                if (n < 0) {
                    perror("recv");
                }
                break;
            }

            if (send(s2, str, n, 0) < 0) {
                perror("send");
                break;
            }
        } while (1);

        close(s2);
    }

    return 0;
}
