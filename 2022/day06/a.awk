#5:54

function all_different(s){
    s1 = substr(s, 1, 1)
    s2 = substr(s, 2, 1)
    s3 = substr(s, 3, 1)
    s4 = substr(s, 4, 1)
    if(s1 == s2){ return(0) }
    if(s1 == s3){ return(0) }
    if(s1 == s4){ return(0) }
    if(s2 == s3){ return(0) }
    if(s2 == s4){ return(0) }
    if(s3 == s4){ return(0) }
    return(1)
}


function loop(n, s,        b){
    s2 = substr(s, 1, 4)
    b = all_different(s2)

    if(b){
        return(n)
    } else {
        return(loop(n+1, substr(s, 2)))
    }
}

{
    s = $0
    r = loop(4, s)
    print(r)
}
