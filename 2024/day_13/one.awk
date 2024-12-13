#fewest tokens to win all prizes.
#A costs 3, B costs 1.

function cost(AX, AY, BX, BY, X, Y,        V, CX, CY){
    V = 0
    for(i=0; i<=100; i++){
        CX = X - (AX * i)
        CY = Y - (AY * i)

        if(((CX % BX) == 0) &&((CY % BY) == 0) &&
           (int(CX / BX) == int(CY / BY))){
            V += 3*i
            V += int(CX / BX)
            return(V)
        }
    }
    #print("not buyable")
    return(0)
}

/Button A/ {
    s = $0
    match(s, /[0-9]+/)
    AX = substr(s, RSTART, RLENGTH)
    sub(/[0-9]+/, "", s)
    match(s, /[0-9]+/)
    AY = substr(s, RSTART, RLENGTH)
}

/Button B/ {
    s = $0
    match(s, /[0-9]+/)
    BX = substr(s, RSTART, RLENGTH)
    sub(/[0-9]+/, "", s)
    match(s, /[0-9]+/)
    BY = substr(s, RSTART, RLENGTH)
}

/Prize/ {
    s = $0
    match(s, /[0-9]+/)
    X = substr(s, RSTART, RLENGTH)
    sub(/[0-9]+/, "", s)
    match(s, /[0-9]+/)
    Y = substr(s, RSTART, RLENGTH)
    V = cost(AX, AY, BX, BY, X, Y)
    if(!(V == 0)){
        sum += V
        winners += 1
    }
}

END{
    print("costs: " sum " games: " winners)
}
