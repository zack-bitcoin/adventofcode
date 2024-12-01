function sort(L, size, file,        i, s) {
    s = L[1]
    for(i=2; i<=size; i++){
        s = s "\n" L[i]
    }
    command = "sort > " file
    print(s) | command
    close(command)
}
function diff(a, b){
    if(a > b){return(a - b)}
    else{return(b - a)}
}

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
    F1 = "file1"
    F2 = "file2"
    sort(L1, NR, F1)
    sort(L2, NR, F2)
    sum = 0
    while((getline < F1) > 0) {
        a = $0
        getline < F2
        b = $0
        sum += diff(a, b)
    }
}
