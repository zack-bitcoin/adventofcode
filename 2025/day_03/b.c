#include <stdio.h>
//int DIGITS = 15;
//int LETTERS = 2;
int DIGITS = 100;//change to 15 for example data
int LETTERS = 12;//change to 2 for part 1
int max(int a, int b){
  if(a > b){return(a);}
  {return(b);}
}
int highest_digit(int s[], int start, int end){
  int m0;
  int m = 0;
  int highest = 0;
  for(int i=start; i<=end; i++){
    m0 = m;
    m = max(m, s[i]);
    if(m > m0){
      highest = i;
    }
  }
  return(highest);
}
long long max_joltage(int s[], int start, int digits, long long acc){
  if(digits == 0){return(acc);}
  int start2 = highest_digit(s, start, DIGITS - digits);
  return(max_joltage(s, start2+1, digits-1, (acc*10)+s[start2]));
}
int main()
{
  int c;
  int s[DIGITS];
  int i = 0;
  long long sum = 0;
  long long mj = 0;

  c = getchar();
  while(c != EOF){
    if((c >= '0') && (c <= '9')){
      s[i] = c - '0';
      i++;
    }
    if(c == '\n'){
      mj = max_joltage(s, 0, LETTERS, 0);
      sum += mj;
      i = 0;
    }
    c = getchar();
  }
  printf("result: %lld\n", sum);
}
