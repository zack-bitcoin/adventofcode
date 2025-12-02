#include <stdio.h>
long long pow2(long long a, long long n){
  if(n == 0){return(1);}
  if(n == 1){return(a);}
  if((n % 2) == 0){return(pow2(a*a, n/2));}
  return(a*pow2(a, n-1));
}
int digits(long long n){
  if(n < 1){ return(0);}
  if(n < 10){ return(1);}
  return(1+digits(n/10));
}
long long equal_all(long long n, int step, long long base){
  int l = digits(n);
  int steps = l/step;
  if(step >= l){return(0);}
  if(!(l == (steps * step))){return(0);}
  long long p = pow2(10, step);
  for(int i = 0; i<steps; i++){
    long long val = n % p;
    if(!(base == val)){return(0);}
    n = n / p;
  }
  return(1);
}
long long is_invalid2(long long n, int letters){
  long long p = pow2(10, letters);
  long long n1 = n % p;
  return(equal_all(n, letters, n1));
}
long long is_invalid(long long n){
  int l = digits(n);
  for(int i=1; i<l; i++)
    if(is_invalid2(n, i))
      return(1);
  return(0);
}
long long scan(long long start, long long end){
  long long r = 0;
  for(long long i=start; i<=end; i++)
    if(is_invalid(i))
      r += i;
  return(r);
}
int main()
{
  int c;
  long long sum = 0;
  int loading_flag = 1;
  long long val1 = 0;
  long long val2 = 0;
  c = getchar();
  while(c != EOF){
    //entry split on ","
    //data splti on "-"
    if((c >= '0') && (c <= '9')){
      if(loading_flag == 1){
        val1 = (val1 * 10) + (c - '0');
      } else if(loading_flag == 2){
        val2 = (val2 * 10) + (c - '0');
      }
    }
    if(c == ','){
      sum += scan(val1, val2);
      val1 = 0;
      val2 = 0;
      loading_flag = 1;
    }
    if(c == '-'){
      loading_flag = 2;
    }
    c = getchar();
  }
  sum = sum +  scan(val1, val2);
  printf("result is %lld\n", sum);
  return(0);
}
