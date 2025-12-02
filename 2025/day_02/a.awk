BEGIN{
    sum = 0
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
function scan(start, end,       i){
    for(i=start; i<= end; i++){
        if(is_invalid(i)){
            sum+= i
        }
    }
}
function is_invalid(n){
    n = n ""
    l = length(n)
    l2 = int(l/2)
    a = substr(n, 1, l2)
    b = substr(n, l2+1)
    return(b == a)
}
