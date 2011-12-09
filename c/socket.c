// Server code in C

#include <sys/types.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <stdio.h>
#include <stdlib.h>
#include <strings.h>

int main()
{
    int32_t i32SocketFD = socket(AF_INET, SOCK_STREAM, 0);

    if(0 == i32SocketFD)
    {
      printf("can not create socket");
      exit(-1);
    }

    struct sockaddr_in stSockAddr;
    memset(&stSockAddr, 0, sizeof(stSockAddr));
 
    stSockAddr.sin_family = AF_INET;
    stSockAddr.sin_port = htons(1100);
    stSockAddr.sin_addr.s_addr = htonl(INADDR_ANY);

    if(-1 == bind(i32SocketFD,(struct sockaddr*) &stSockAddr, sizeof(stSockAddr)))
    {
      printf("error bind failed");
      exit(-1);
    }

    if(-1 == listen(i32SocketFD, 10))
    {
      printf("error listen failed");
      exit(-1);
    }
 
    for(; ;)
    {
      int32_t i32ConnectFD = accept(i32SocketFD, NULL, NULL);
 
      if(0 > i32ConnectFD)
      {
        printf("error accept failed");
        exit(-1);
      }
 
      shutdown(i32ConnectFD, 2);
 
      close(i32ConnectFD);
    }
    return 0;
} 
