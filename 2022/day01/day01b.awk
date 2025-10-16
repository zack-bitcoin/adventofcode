BEGIN{
    X = 0
    Max = 0
    ManyElfs = 1
}

/[0-9]+/ {
    X = X + $0
}

/^$/ {
    Elfs[ManyElfs] = X
    X = 0
    ManyElfs += 1
}

function biggest(Many, Elfs, N,     i, B, Biggest){
    if(Many == 0){
        return(0)
    }
    B = 0
    for(i=0; i<=N; i++){
        if(Elfs[i] > B){
            B = Elfs[i]
            Biggest = i
        }
    }
    Elfs[Biggest] = 0
    return(B + biggest(Many-1, Elfs, N))
}


END {
    Elfs[ManyElfs] = X
    X = 0
    ManyElfs += 1
    print(biggest(3, Elfs, ManyElfs-1))
}
