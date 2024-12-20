{
    cols = length($0)
    for(i=1; i<=cols; i++){
        #Grid[col, row]
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
}

END{
    rows = NR
    print(rows " " cols " " start_row " " start_col " " end_row " " end_col)
    basic = calc_distances(start_row, start_col, end_row, end_col, 0)
    print("basic " basic)
    for(i=2; i<=(cols-1); i++){
        for(j=2; j<=(rows-1); j++){
            if(Grid[i, j] == "#"){
                Grid[i, j]="."
                cheat = calc_distances(start_row, start_col, end_row, end_col, 0)
                if(cheat < basic){
                    print("cheat " i " " j " is " basic - cheat" faster.")
                    if((basic - cheat) >= 100){
                        sum += 1
                    }
                }
                Grid[i, j] = "#"
            }
        }
    }
    print(sum)
}

function calc_distances(sr, sc, er, ec, r,      Distances, a, b, c, d, bool, D1){
    if(sr > rows){return(100000000)}
    if(sc > cols){return(10000000)}
    if(sr < 1){return(1000000)}
    if(sc < 1){return(100000000)}
    if(Grid[sc, sr] == "#"){
        return(1000000000)
    }
    if((!(Distances[sc, sr])) || (r < Distances[sc, sr])){
        if(r < Distances[sc, sr]){
        }
        Distances[sc, sr] = r
        calc_distances(sr+1, sc, er, ec, r+1, Distances)
        calc_distances(sr, sc-1, er, ec, r+1, Distances)
        calc_distances(sr-1, sc, er, ec, r+1, Distances)
        calc_distances(sr, sc+1, er, ec, r+1, Distances)
    }
    return(Distances[ec, er])
}

function min(a, b){
    if((!(a)) && (!(b))){return(0)}
    if(!(a)){return(b)}
    if(!(b)){return(a)}
    if(a < b){return(a)}
    else{return(b)}
}
