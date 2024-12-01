{
    match($0, /[0-9]+/)
    n1 = substr($0, RSTART, RLENGTH)
    sub(/[0-9]+/, "", $0)
    match($0, /[0-9]+/)
    n2 = substr($0, RSTART, RLENGTH)
    sub(/[0-9]+/, "", $0)
    L1[NR] = n1
    L2[NR] = n2
}

END{
    for(i=1; i<=NR; i++){
        counter = 0
        for(j=1; j<=NR; j++){
            if(L1[i] == L2[j]){
                counter++
            }
        }
        sum += (counter * L1[i])
    }
    print(sum)
}
