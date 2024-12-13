
#fewest tokens to win all prizes.
#A costs 3, B costs 1.

function cost(AX, AY, BX, BY, X, Y,        V, VT, VB, U){

    #choose U and V such that AX*U + BX*V = X and AY*U + BY*V = Y

    # AX*U = X - BX*V
    # U = (X - BX*V)/AX

    # AY*U = Y - BY*U
    # U = (Y - BY*Y)/AY

    #(X - BX*V)/AX = (Y - BY*V)/AY
    #(X - BX*V)*AY = (Y - BY*V)*AX
    #X*AY - BX*V*AY = Y*AX - BY*V*AX
    #X*AY - Y*AX = BX*V*AY - BY*V*AX
    #(X*AY - Y*AX) = V(BX*AY - BY*AX)
    #V = (X*AY - Y*AX)/(BX*AY - BY*AX)

    VT = ((X*AY) - (Y*AX))
    VB = ((BX*AY) - (BY*AX))

    if((VT % VB) == 0){#check that V is an integer
        V = int(VT/VB)
        if(((Y - (BY*V)) % AY) == 0) {#check that U is an integer
            U = int((Y - (BY*V)) / AY)
            return((U*3) + V)
        }
    }
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
    X = substr(s, RSTART, RLENGTH) + 10000000000000
    sub(/[0-9]+/, "", s)
    match(s, /[0-9]+/)
    Y = substr(s, RSTART, RLENGTH) + 10000000000000
    V = cost(AX, AY, BX, BY, X, Y)
    if(!(V == 0)){
        sum += V
        winners += 1
    }
}

END{
    print("costs: " sum " games: " winners)
}

