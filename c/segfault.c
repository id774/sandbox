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

