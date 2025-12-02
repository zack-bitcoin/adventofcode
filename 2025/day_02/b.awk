BEGIN{
    sum = 0
    #print(" try " equal_all(123123123, 3, 123))
    #print(" try " equal_all(1231231230, 3, 123))
    #print("try " is_invalid2(1212, 2))
    #print("try " is_invalid2(1213, 2))
    #print("try " is_invalid2(111, 1))
    #print("try " is_invalid2(112, 1))
    #print("try " is_invalid(10))
    print("try " is_invalid(11))
    print("try " is_invalid(2323))
    print("try " is_invalid(23230))
    print("try " is_invalid(232323))
    print("try " is_invalid(2323230))
    #exit
}

{
    M = split($0, A, ",")
    for(i=1; i<=M; i++){
        print(A[i])
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

function is_invalid_old(n){
    n = n ""
    l = length(n)
    l2 = int(l/2)
    a = substr(n, 1, l2)
    b = substr(n, l2+1)
    return(b == a)
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
    #print("is invalid2 " n " " letters)
    #n = n ""
    #l = length(n)
    #l2 = int(l/letters)
    a = substr(n, 1, letters)
    return(equal_all(n, letters, a))
}
function equal_all(n, step, base,      l, steps, i){
    #print("equal_all " n " " step " " base)
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
