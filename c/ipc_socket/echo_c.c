#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>
#include <string.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
 
int main()
{
    int s, t;
    struct sockaddr_in server;
    char str[BUFSIZ];

    if ((s = socket(PF_INET, SOCK_STREAM, 0)) < 0) {
        perror("socket");
        exit(1);
    }

    memset((char *)&server, 0, sizeof(server));
    server.sin_family = PF_INET;
    server.sin_addr.s_addr  = inet_addr("127.0.0.1");
    server.sin_port = htons(3000);
    if (connect(s, (struct sockaddr *)&server, sizeof(server)) < 0) {
        perror("connect");
        exit(1);
    }

    printf("Connected.\n");

    while(printf("> "), fgets(str, BUFSIZ, stdin), !feof(stdin)) {
        if (send(s, str, strlen(str), 0) < 0) {
            perror("send");
            exit(1);
        }

        if ((t=recv(s, str, BUFSIZ, 0)) > 0) {
            str[t] = '\0';
            printf("echo> %s", str);
        } else {
            if (t < 0) {
                perror("recv");
            } else {
                printf("Server connection closed\n");
            }
            exit(1);
        }
    }

    close(s);

    return 0;
}
