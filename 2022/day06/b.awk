#10:56
function is_in(l, s){
    if(match(s, l)){
        #print("is in " l " " s)
        return(1)
    }
    return(0)
}

function all_different(s){
    if(length(s) == 0){
        return(1)
    }
    if(is_in(substr(s, 1, 1), substr(s, 2))){
        return(0)
    }
    return(all_different(substr(s, 2)))
}


function loop(n, s,        b){
    #print("loop " n " " s)
    s2 = substr(s, 1, 14)
    b = all_different(s2)

    if(b){
        return(n)
    } else {
        return(loop(n+1, substr(s, 2)))
    }
}

{
    s = $0
    r = loop(14, s)
    print(r)
}
