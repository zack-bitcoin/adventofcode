#include <stdio.h>

int pow2(int a, int n){
  if(n == 0){return(1);}
  if(n == 1){return(a);}
  if((n % 2) == 0){return(pow2(a*a, n/2));}
  return(a*pow2(a, n-1));
}

int digits(int n){
  if(n < 1){ return(0);}
  if(n < 10){ return(1);}
  return(1+digits(n/10));
}

int is_invalid(int n){
  int d = digits(n);
  int d2 = d/2;
  int p = pow2(10, d2);
  int n1 = n % p;
  int n2 = n / p;
  return(n1 == n2);
}

int scan(int start, int end){
  int r = 0;
  for(int i=start; i<=end; i++){
    if(is_invalid(i)){
      r += i;
    }
  }
  return(r);
}

int main()
{
  int c;
  int sum = 0;
  int loading_flag = 1;
  int val1 = 0;
  int val2 = 0;
  
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
  sum += scan(val1, val2);
  printf("sum is %i\n", sum);
}

