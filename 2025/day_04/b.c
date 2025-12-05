#include <stdio.h>

int Cols = 139;
int Rows = 139;
int Grid[19321];

int is_roll(int row, int col){
  if((row >= Rows) || (row < 0) || (col >= Cols) || (col < 0)){
    return(0);
  } else {
    int g = Grid[(row*Cols)+col];
    return(g > 0);
  }
}
int many_neighbors(int row, int col){
  int r = 0;
  for(int i=-1; i<=1; i++)
    for(int j=-1; j<=1; j++)
      r += is_roll(row + i, col + j);
  return(r);
}
int clear()
{
  for(int i=0; i< Rows; i++)
    for(int j=0; j<Cols; j++){
      int pos = (i*Cols)+j;
      if(Grid[pos] == 2)
        Grid[pos] = 0;
    }
  return(0);
}
int step()
{
  int result = 0;
  for(int i=0; i<Rows; i++)
    for(int j=0; j<Cols; j++){
      int pos = (i*Cols) + j;
      if(Grid[pos] == 1)
        if(many_neighbors(i, j) < 5){
          Grid[pos] = 2;
          result += 1;
        }
    }
  return(result);
}
int mainloop(int sum)
{
  int result = step();
  sum += result;
  clear();
  if(result > 0){
    return(mainloop(sum));
  } else {
    return(sum);
  }
}
int main()
{
  int c;
  c = getchar();
  int pos = 0;
  while(c != EOF){
    if(c == '\n'){
    } else if(c == '.'){
      Grid[pos] = 0;
      pos += 1;
    } else if(c == '@'){
      Grid[pos] = 1;
      pos += 1;
    }
    c = getchar();
  }
  int sum = mainloop(0);
  printf("final sum: %i\n", sum);
}
