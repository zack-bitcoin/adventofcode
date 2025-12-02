BEGIN{
    sum = 0
    print("try " is_invalid(10))
    print("try " is_invalid(11))
    print("try " is_invalid(2323))
    print("try " is_invalid(23230))
}

{
    M = split($0, A, ",")
    for(i=1; i<=M; i++){
        split(A[i], B, "-")
        start = B[1]
        end = B[2]
        scan(start, end)
    }
}

END{
    print("result " sum)
}

function scan(start, end){
    if(start > end){
        return(0)
    }
    if(is_invalid(start)){
        sum += start
    }
    return(scan(start+1, end));
}

function is_invalid(n){
    n = n ""
    l = length(n)
    l2 = int(l/2)
    a = substr(n, 1, l2)
    b = substr(n, l2+1)
    return(b == a)
}
