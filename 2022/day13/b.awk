#1:18:03

#uses bubble sort.

BEGIN{
    lines = 1
}
{
    if(length($0) > 0){
        data[lines] = $0
        lines += 1
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
    ll = (substr(left, 1, 1) == "[")
    rl = (substr(right, 1, 1) == "[")
    if(!(ll) && !(rl)){
        if((left + 0) < (right + 0)){
            return(1)
        }
        if((right + 0) < (left + 0)){
            #print("reverse order")
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
    depth = 0
    p = 2
    while(1){
        if(depth < 0){
            print("impossible error")
            error()
        }
        l = substr(s, p, 1)
        if((depth == 0) && ((l == ","))){
            return("[" substr(s, p+1))
        }
        if((depth == 0) && (l == "]")){
            return("[" substr(s, p))
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
    }
}

END {
    data[lines] = "[[2]]"
    data[lines+1] = "[[6]]"
    lines += 2

    for(ko=1; ko<=lines; ko++){
        print(ko "/" lines)
        for(i=1; i<lines-1; i++){
            if(order_check(data[i], data[i+1]) == -1){
                temp = data[i]
                data[i] = data[i+1]
                data[i+1] = temp
            }
        }
    }
    result = 1
    for(i=1; i<lines; i++){
        if(data[i] == "[[2]]"){
            result *= i
        }
        if(data[i] == "[[6]]"){
            result *= i
        }
    }
    print(result)
}
