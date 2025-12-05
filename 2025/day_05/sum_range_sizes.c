#include <stdio.h>
int main(){
  int c;
  c = getchar();
  int flag = 0;
  long long x = 0;
  long long y = 0;
  long long sum = 0;
  while(c != EOF){
    if(c == '\n'){
      sum += (y - x + 1);
      flag = 0;
      x = 0;
      y = 0;
    } else if ((c >= '0') && (c <= '9')){
      if(flag == 0){
        x = (x*10) + (c - '0');
      } else if(flag == 1){
        y = (y*10) + (c - '0');
      }
    } else if (c == ' '){
      flag = 1;
    }
    c = getchar();
  }
  printf("result: %llu\n", sum);
  return(0);
}
