#include <stdio.h>

int main()
{
  int c;
  int distance = 0;
  int position = 50;
  int acc = 0;
  int sign = 1;

  c = getchar();
  while(c != EOF){
    if(c == '\n'){
      position = (position + (sign * distance) + 100) % 100;
      if(position == 0){
        acc += 1;
      }
      distance = 0;
      sign = 1;
    } else if(c == 'L'){
      sign = -1;
    } else if(c == 'R'){
    } else if((c >= '0') && (c <= '9')){
      distance = (c - '0') + (distance * 10);
    }
    c = getchar();
  }
  printf("acc is %i\n", acc);
}
