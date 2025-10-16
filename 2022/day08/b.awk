
BEGIN {
    size = 99
    total = 0
}

function score(x, y,      tree, right, i, tree2, left, up, down ){
    #multiply how far you can see in each direction.
    tree = Grid[x][y]

    right = 0
    for(i=x+1; i<=size; i++){
        right += 1
        tree2 = Grid[i][y]
        if(tree2 < tree){
        } else {
            i=size+1
        }
    }

    left = 0
    for(i=x-1; i>0; i--){
        left += 1
        tree2 = Grid[i][y]
        if(tree2 < tree){
        } else {
            i=0
        }
    }

    up = 0
    for(i=y-1; i>0; i--){
        up += 1
        tree2 = Grid[x][i]
        if(tree2 < tree){
        } else {
            i=0
        }
    }

    down = 0
    for(i=y+1; i<=size ; i++){
        down += 1
        tree2 = Grid[x][i]
        if(tree2 < tree){
        } else {
            i=size+1
        }
    }
    return(right * left * up * down)
}

{
    for(i=1; i<=size; i++){
        Grid[NR][i] = substr($0, i, 1)
    }
}

END {
    for(i=1; i<=size; i++){
        for(j=1; j<=size; j++){
            s = score(i, j)
            if(s > max_score){
                max_score = s
            }
        }
    }
    print(max_score)
}
