function step_size_check(a, m){
    for(i = 1; i<=(m-1); i++){
        if(a[i] == a[i+1]){
            return(0)
        }
        if(a[i] > a[i+1]+3){
            return(0)
        }
        if(a[i] < a[i+1]-3){
            return(0)
        }
    }
    return(1)
}
function increasing(a, m){
    for(i = 1; i<=(m-1); i++){
        if(a[i] > a[i+1]){
            return(0)
        }
    }
    return(1)
}
function decreasing(a, m){
    for(i = 1; i<=(m-1); i++){
        if(a[i] < a[i+1]){
            return(0)
        }
    }
    return(1)
}
function monotonic(a, m){
    if(a[2] > a[1]){
        return(increasing(a, m))
    }
    return(decreasing(a, m))
}
{
    m = split($0, a, " ")
    if(step_size_check(a, m) && monotonic(a, m)){
        sum+=1
    }
}

END{ print(sum)}
