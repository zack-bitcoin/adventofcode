function many_stones2(Data, Blinks,     sum, m, i, D){
    m = split(Data, D)
    if(Blinks == 0){
        return(m)
    }
    sum = 0
    for(i=1; i<=m; i++){
        sum += many_stones_depth(D[i], Blinks)
    }
    return(sum)
}
function many_stones_depth(N, Blinks,      D, r){
    if(Blinks == 0){
        return(1)
    }
    if(N == 0){
        return(many_stones_depth(1, Blinks-1))
    }
    if((N, Blinks) in Cache){
        return(Cache[N, Blinks])
    }
    D = one_blink(N)
    r = many_stones2(D, Blinks-1)
    Cache[N, Blinks] = r
    return(r)
}
function one_blink(N,      l){
    if(!(N)){
        print("one blink error")
        return(0)
    }
    l = length(N)
    if((l % 2) == 0){
        lh = l/2
        return(substr(N, 1, lh)+0 " " substr(N, lh+1)+0)
    }
    return(N*2024 "")
}
{
    Data = $0
}

END{
    Blinks = 75
    print(many_stones2(Data, Blinks))
}
