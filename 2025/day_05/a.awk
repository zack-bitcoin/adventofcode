BEGIN{
    r = 1
    sum = 0
}
/-/ {
    split($0, A, "-")
    start = A[1]
    end = A[2]
    ranges_start[r] = start
    ranges_end[r] = end
    r += 1
}
/^[0-9]+$/ {
    if(is_fresh($0)){
        sum += 1
    }
}
function in_range(x, a, b){
    return((x >= a) && (x <= b))
}
function is_fresh(n){
    for(i=1; i<=r; i++){
        if(in_range(n, ranges_start[i], ranges_end[i])){
            return(1)
        }
    }
    return(0)
}
END{
    print("result: " sum)
}
