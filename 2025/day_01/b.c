#include <stdio.h>
int position, acc;
int clicks(int x, int n){
  if(x > 99){
    acc += 1;
    return(clicks(x-100, n));
  };
  if(x == 0){
    return(0);
  }
  position += n;
  position = (100 + position) % 100;
  if(position == 0){
    acc += 1;
  }
  return(clicks(x-1, n));
}
int main()
{
  int c;
  int distance = 0;
  position = 50;
  acc = 0;
  int sign = 1;
  c = getchar();
  while(c != EOF){
    if(c == '\n'){
      clicks(distance, sign);
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

