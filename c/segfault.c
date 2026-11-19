/*
 * segfault.c: Trigger a segmentation fault with an array overrun
 *
 * Description:
 * Overrun a fixed size array on purpose to trigger a segmentation fault.
 * GetMngFile writes up to 999 entries into a two-element global array and
 * prints each index and value until the process crashes.
 *
 * Author: id774 (More info: https://id774.net)
 * Source Code: https://github.com/id774/sandbox
 * License: The GPL version 3, or LGPL version 3 (Dual License).
 * Contact: idnanashi@gmail.com
 *
 * Build / Run:
 *     cc -o segfault segfault.c
 *     ./segfault
 *
 * Requirements:
 * - A C compiler that accepts the pre-C99 implicit declaration of GetMngFile
 *   and its K&R-style definition
 */

#include<stdio.h>
#include<string.h>

#define DATA "TEST"

char mngfile[2][50];

int main()
{
  memset( mngfile, '\0', sizeof(mngfile) );
  GetMngFile(mngfile);
  return 0;
}

int GetMngFile( mngfile )
  char            mngfile[2][50];
{
  int i=0;
  char    file[128];
  for(i=0;i<999;i++)
  {
    memset( file, '\0', sizeof(file) );

    strcpy(file,"abc");
    sprintf(mngfile[i],"%s_%s",file,DATA);
    printf("%d,%s\n",i,mngfile[i]);
  }
  return 0;
}

