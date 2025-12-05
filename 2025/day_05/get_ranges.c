#include <stdio.h>

int main()
{
  int c;
  c = getchar();
  int ending_flag = 0;
  while(c != EOF){
    if((c == '\n') && (ending_flag == 1)){
      return(0);
    }else if(c == '\n'){
      ending_flag = 1;
      putchar(c);
    } else if ((c >= '0') && (c <= '9')){
      ending_flag = 0;
      putchar(c);
    } else if (c == '-'){
      putchar(' ');
    }
    c = getchar();
  }
  return(0);
}
