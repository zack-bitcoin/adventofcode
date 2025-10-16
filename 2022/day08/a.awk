#23:30

BEGIN {
    size = 99
    total = 0
}

function visible(x, y,            s1, i, s2, s3, j) {
    #this tree is taller than everything in one of the 4 directions.
    s1 = Grid[x][y]
    check = 1
    for(i=1; i<x; i++){
        s2 = Grid[i][y]
        if(s2 >= s1){
            check = 0
        }
    }
    if(check) { return(1)}

    check = 1
    for(i=x+1; i<=size; i++){
        s2 = Grid[i][y]
        if(s2 >= s1){
            check = 0
        }
    }
    if(check) { return(1)}

    check = 1
    for(i=1; i<y; i++){
        s2 = Grid[x][i]
        if(s2 >= s1){
            check = 0
        }
    }
    if(check) { return(1)}

    check = 1
    for(i=y+1; i<=size; i++){
        s2 = Grid[x][i]
        if(s2 >= s1){
            check = 0
        }
    }
    if(check) { return(1)}
    return(0)
}

{
    for(i=1; i<=size; i++){
        Grid[NR][i] = substr($0, i, 1)
    }
}

END {
for(i=1; i<=size; i++){
        for(j=1; j<=size; j++){
            v = visible(i, j)
            if(v){
                #print("tallest at " i " " j)
                total += 1
            } else {
                print("not visible "i " " j)
        }
    }
}
    print(total)
}
