{
    cols = length($0)
    for(i=1; i<=cols; i++){
        Grid[i, NR] = substr($0, i, 1)
    }
}

/S/ {
    start_row = NR
    match($0, /S/)
    start_col = RSTART
}

/E/ {
    end_row = NR
    match($0, /E/)
    end_col = RSTART
    rows = length($0)
}
END{
    CheatTime=2
    basic1 = calc_distances(start_row, start_col, end_row, end_col, 0, D2S)
    basic2 = calc_distances(end_row, end_col, start_row, start_col, 0, D2E)
    Uncheated = basic1
    print(Uncheated)
    sum = 0
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            if(!((j, i) in D2S)){
                    D2S[j, i] = 100000000000
                }
            if(!((j, i) in D2E)){
                    D2E[j, i] = 100000000000
                }
        }
    }
    Bound = 20
    for(i=1; i<=rows; i++){
        print("i: " i)
        for(j=1; j<=cols; j++){
            v1 = D2S[j, i]
            for(i2=max(1, i-Bound); i2<=min(rows, i+Bound); i2++){
                Bound3 = Bound - abs(i-i2)
                for(j2=max(1, j-Bound3); j2<=min(cols, j+Bound3); j2++){
                        D = v1 + D2E[j2, i2] + abs(i-i2)+abs(j-j2)
                        if((Uncheated - D) > 99){
                            sum+=1
                        }
                }
            }
        }
    }
    print(sum)
}
function abs(x){
    if(x > 0){return(x)}
    return(-x)
}
function max(x, y){
    if(x > y){return(x)}
    return(y)
}
function min(x, y){
    if(x < y){return(x)}
    return(y)
}

function calc_distances(row, col, erow, ecol, distance, Distances){
    if(row > rows){return(100000000)}
    if(col > cols){return(10000000)}
    if(row < 1){return(1000000)}
    if(col < 1){return(100000000)}
    if(Grid[col, row] == "#"){
        return(1000000000)
    }
    if((!((col, row) in Distances)) || (distance <= Distances[col, row])){
        Distances[col, row] = distance
        calc_distances(row+1, col, erow, ecol, distance+1, Distances)
        calc_distances(row, col-1, erow, ecol, distance+1, Distances)
        calc_distances(row-1, col, erow, ecol, distance+1, Distances)
        calc_distances(row, col+1, erow, ecol, distance+1, Distances)
    }
    if((ecol, erow) in Distances){
        return(Distances[ecol, erow])
    } else {
        return(0)
    }
}
