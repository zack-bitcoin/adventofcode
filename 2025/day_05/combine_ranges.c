#include <stdio.h>
#define Buff 300
long long Starts[Buff];
long long Ends[Buff];

long long max(long long a, long long b){
  if(a > b){return(a);}
  return(b);
}
int try_combine(long long start, long long end, int line, int NR)
{
  if(line > NR){
    printf("%llu %llu\n", start, end);
    return(line+1);
  }
  if(end >= Starts[line]){
    return(try_combine(start, max(end, Ends[line]), line+1, NR));
  } else {
    printf("%llu %llu\n", start, end);
    return(line);
  }
}
int print_result_unused(int line, int NR)
{
  if(line >= NR){
    return(0);
  }
  printf("%llu %llu\n", Starts[line], Ends[line]);
  return(print_result_unused(line+1, NR));
}
int print_result(int line, int NR)
{
  if(line == NR){
    printf("%llu %llu\n", Starts[NR], Ends[NR]);
  }
  if(line >= NR){
    return(0);
  }
  int line2 = try_combine(Starts[line], Ends[line], line+1, NR);
  return(print_result(line2, NR));
}
int main()
{
  int c;
  c = getchar();
  int line = 1;
  int rn = 1;
  for(int i=0; i<Buff; i++){
    Starts[i] = 0;
    Ends[i] = 0;
  }
  while(c != EOF){
    if((c == '\n')){
      line += 1;
      rn = 1;
    } else if (c == ' '){
      rn = 2;
    } else if ((c >= '0') && (c <= '9')){
      if(rn == 1){
        Starts[line] = (10*Starts[line]) + (c - '0');
      } else if(rn == 2){
        Ends[line] = (10*Ends[line]) + (c - '0');
      }
    }
    c = getchar();
  }
  print_result(1, line-1);
  return(0);
}
