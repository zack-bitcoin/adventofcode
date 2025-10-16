#46:12

BEGIN{
    RS = ""
    FS = "\n"
    #print(tl2("[4]"))
#    print(hd2("[[1,2],3]"))
#error()

}

{
    right = $2
    left = $1
    print("left" left "right " right)
    if(order_check(left, right) == 1){
        print(NR)
        total += NR
    }
}
function order_check(left, right){
    if(left == right){
        return(0)
    }
    if((left == "[]") &&(right == "[]")){
        return(0)
    }
    if((left == "[]")){
        return(1)
    }
    if((right == "[]")){
        return(-1)
    }
    print("order check " left " " right)
    ll = (substr(left, 1, 1) == "[")
    rl = (substr(right, 1, 1) == "[")
    if(!(ll) && !(rl)){
        if((left + 0) < (right + 0)){
            return(1)
        }
        if((right + 0) < (left + 0)){
            print("reverse order")
            return(-1)
        }
        return(0)
    }
    if(!(ll)){
        return(order_check("["left"]", right))
    }
    if(!(rl)){
        return(order_check(left, "["right"]"))
    }
    bool = order_check(hd2(left), hd2(right))
    if(bool == 1){ return (1) }
    if(bool == -1){return(-1) }
    return(order_check(tl2(left), tl2(right)))
}
function tl2(s){
    if(s == "[]"){
        error()
    }
    if(match(s, /^\[[0-9]+\]$/)){
        #return(substr(s, 2, length(s)-2))
        return("[]")
    }
    depth = 0
    p = 2
    while(1){
        if(depth < 0){
            print("impossible error")
            error()
        }
        l = substr(s, p, 1)
        if((depth == 0) && ((l == ",") || (l == "]"))){
            return("[" substr(s, p+1))
        }
        if(l == "["){
            depth += 1
        }
        if(l == "]"){
            depth -= 1
        }
        p+=1
    }
}
function hd2(s){
    #print("hd2 " s)
    if(s == "[]"){
        error()
    }
    r = ""
    depth = 0
    p = 2
    while(1){
        if(depth < 0){
            print("s: " s)
            print("r: " r)
            print("impossible error")
            error()
        }
        l = substr(s, p, 1)
        if((depth == 0) && ((l == ",") || (l == "]") || (!l))){
            return(r)
        }
        r = r l
        if(l == "["){
            depth += 1
        }
        if(l == "]"){
            depth -= 1
        }
        p+=1
        #print("hd2 loop " p " " depth " " l)
    }
}

END {
    print(total)
}
