function minimum(s){
    m = 100000000000000000000
    while(match(s, /[0-9]+/)){
        n = substr(s, RSTART, RLENGTH)
        if(n+0 < m+0){
            m = n}
        sub(/[0-9]+/, "", s)
    }
    return(m)
}
BEGIN{
    many_maps = 0
}

/seeds:/ {
split($0, a, ":")
print("seeds are: " a[2])
seeds1 = a[2]
seeds0 = ""
}

/map:/{
    seeds0 = seeds0 " " seeds1
    seeds1 = ""
}

/^[0-9]+ [0-9]+ [0-9]+$/{
    #print(seeds0 " , " seeds1)
    s = seeds0
    seeds0 = ""
    split($0, x, " ")
    destination = x[1]
    source = x[2]
    range = x[3]
    #print("destination: " destination)
    #print("source: " source)
    #print("range: " range)
    while(match(s, /[0-9]+/)){
        n = substr(s, RSTART, RLENGTH)
        if((n+0 >= source+0) && (n+0 < (source + range))){
            seeds1 = seeds1 " " (n + destination - source)
        } else {
            seeds0 = seeds0 " " n
        }
        sub(/[0-9]+/, "", s)
    }
}

END {
    print(seeds0 ", " seeds1)
    print(minimum(seeds0 " " seeds1))
}


#too high 820956045
