# 00:20:05
#rank 2819


#roll is accessible if fewer than 4 adjacent tiles are rolls

BEGIN{

}

{
    l = length($0)
    for(i=1; i<=l; i++){
        Grid[NR][i] = substr($0, i, 1)
    }
}

END{
    Cols = l
    mainloop()
    print("final sum: " sum)
}

function mainloop(){
    result = round()
    sum += result
    clear()
    if(result > 0){
        mainloop()
    }
    #result = round()
    #print("result: " result)
}

function clear(        i, j, g) {
    for(i=1; i<= NR; i++){
        for(j=1; j<=Cols; j++){
            g = Grid[i][j]
            if(g == "x"){
                Grid[i][j] = "."
            }
        }
    }
}

function round(      result, i, j, M){
    result = 0
    for(i=1; i<=NR; i++){
        for(j=1; j<=Cols; j++){
            if(Grid[i][j] == "@"){
                M = many_neighbors(i, j)
                if(M < 4){
                    #print("found x " i " " j)
                    Grid[i][j] = "x"
                    result += 1
                }
            }
        }
    }
    return(result)
}

function many_neighbors(row, col,         r){
    r = is_roll(row-1, col-1) + is_roll(row-1, col) + is_roll(row-1, col+1) + is_roll(row, col-1) + is_roll(row, col+1) + is_roll(row+1, col-1) + is_roll(row+1, col) + is_roll(row+1, col+1)
    #print("many neighbors " row " " col " " r)
    return(r)
}
function is_roll(row, col,        g){
    if((row in Grid) && (col in Grid[row])){
        g = Grid[row][col]
        return(("@" == g) || ("x" == g))
    }
    return(0)
}
