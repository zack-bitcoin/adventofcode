function read_map(row, col){
    if(row < 1){
        return(".")
    }
    if(row > NR){
        return(".")
    }
    if(col < 1){
        return(".")
    }
    if(col > cols){
        return(".")
    }
    return(0+substr(Map[row], col, 1))
}

function all_nines(row, col, n,     u, l, r, d, a1, a2, a3, a4, result){
    if(n+0 == 9){
        return(row " " col "; ")
    }
    u = read_map(row-1, col)
    l = read_map(row, col-1)
    r = read_map(row, col+1)
    d = read_map(row+1, col)

    #print(u " " l " " r " " d)

    a1 = ""
    a2 = ""
    a3 = ""
    a4 = ""
    if(u == (n+1)){
        a1 = all_nines(row-1, col, n+1)
    }
    if(l == (n+1)){
        a2 = all_nines(row, col-1, n+1)
    }
    if(r == (n+1)){
        a3 = all_nines(row, col+1, n+1)
    }
    if(d == (n+1)){
        a4 = all_nines(row+1, col, n+1)
    }
    result = remove_repeats(a1 a2 a3 a4)
    return(result)
}
function includes(r, row, col,        row2, col2){
    while(match(r, /[0-9]+ [0-9]+/)){
        split(substr(r, RSTART, RLENGTH), a, " ")
        row2 = a[1]+0
        col2 = a[2]+0
        if((row == row2) && (col == col2)){
            return(1)
        }
        sub(/[0-9]+ [0-9]+/, "", r)
    }
    return(0)
}
function remove_repeats(l,     r, a, row, col){
    r = ""
    while(match(l, /[0-9]+ [0-9]+/)){
        split(substr(l, RSTART, RLENGTH), a, " ")
        row = a[1]+0
        col = a[2]+0
        if(!(includes(r, row, col))){
            r = r "; " row " " col
        }
        sub(/[0-9]+ [0-9]+/, "", l)
    }
    return(r)
}
function many_points(s,      sum){
    #print("many points " s)
    while(match(s, /[0-9]+ [0-9]+/)){
        sum += 1
        sub(/[0-9]+ [0-9]+/, " ", s)
    }
    return(sum)
}

function get_score(row, col){
    return(many_points(all_nines(row, col, 0)))
}


{
    Map[NR] = $0
    cols = length($0)
}

END{
    for(i=1; i<=NR; i++){
        for(j=1; j<=cols; j++){
            letter = read_map(i, j)
            if(letter == "0"){
                score = get_score(i, j)
                sum += score
            }
        }
    }
    print(sum)
}
