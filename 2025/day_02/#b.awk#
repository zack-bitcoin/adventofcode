BEGIN{
    sum = 0
}
{
    M = split($0, A, ",")
    for(i=1; i<=M; i++){
        split(A[i], B, "-")
        start = B[1]
        end = B[2]
        sum += scan(start, end)
        print("sum is " sum)
    }
}
END{
    print("result " sum)
}
function scan(start, end,     r, i){
    r = 0;
    for(i=start; i<= end; i++){
        if(is_invalid(i)){
            r += i
        }
    }
    return(r);
}
function is_invalid(n,     l, i){
    l = length(n)
    for(i=1; i<l; i++){
        if(is_invalid2(n, i)){
            return(1)
        }
    }
    return(0)
}
function is_invalid2(n, letters,      l, l2, a){
    a = substr(n, 1, letters)
    return(equal_all(n, letters, a))
}
function equal_all(n, step, base,      l, steps, i){
    l = length(n)
    steps = int(l / step)
    if(step >= l){
        return(0)
    }
    if(!(l == (steps * step))){
        return(0)
    }
    for(i=0; i<steps; i++){
        if(!(base == substr(n, (step * i)+1, step))){
            return(0)
        }
    }
    return(1)
}
