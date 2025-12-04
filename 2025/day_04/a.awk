# 00:10:00
# rank 1069


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
    for(i=1; i<=NR; i++){
        for(j=1; j<=l; j++){
            #spot = Grid[i][j]
            if(Grid[i][j] == "@"){
                M = many_neighbors(i, j)
                if(M < 4){
                    print("found x " i " " j)
                    result += 1
                }
            }
        }
    }
    print("result: " result)
}

function many_neighbors(row, col){
    r = is_roll(row-1, col-1) + is_roll(row-1, col) + is_roll(row-1, col+1) + is_roll(row, col-1) + is_roll(row, col+1) + is_roll(row+1, col-1) + is_roll(row+1, col) + is_roll(row+1, col+1)
    #print("many neighbors " row " " col " " r)
    return(r)
}
function is_roll(row, col){
    if((row in Grid) && (col in Grid[row])){
        return("@" == Grid[row][col])
    }
    return(0)
}
