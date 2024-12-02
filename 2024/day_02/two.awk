function step_size_check(a, m,      i){
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
function increasing(a, m,        i){
    for(i = 1; i<=(m-1); i++){
        if(a[i] > a[i+1]){
            return(0)
        }
    }
    return(1)
}
function decreasing(a, m,        i){
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
function check(a, m){
    return(step_size_check(a, m) && monotonic(a, m))
}
{
    m = split($0, a, " ")
    works = 0
    if(check(a, m)){
        #print("works by removing none")
        works = 1
    }
    for(i=1; i<=m; i++){
        b[1] = ""
        b[2] = ""
        b[3] = ""
        b[4] = ""
        c = 0
        for(j=1; j<=m; j++){
            if(!(i == j)){
                c+=1
                b[c] = a[j]
            }
        }
        if(check(b, m-1)){
            #print("works by removing " a[i])
            works = 1
        }
    }
    if(works){
        sum += 1
    }
}
END{ print(sum)}
