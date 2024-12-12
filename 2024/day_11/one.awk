function blink(D,     m, len, xh, r, a, i){
    m = split(D, a)
    r = ""
    for(i=1; i<=m; i++){
        len = length(a[i])
        if((len % 2) == 0){
            xh = len / 2
            r = r " " substr(a[i], 1, xh)+0 " " substr(a[i], xh+1)+0
        } else if(a[i] == "0"){
            r = r " 1"
        } else {
            r = r " " (a[i]*2024)
        }
    }
    return(r)
}
function many_stones(D,      a){
    return(split(D, a))
}

{
    Data = $0
}

END{
    Blinks = 25
    #print(0 " " Data)
    for(i=1; i<=Blinks; i++){
        Data = blink(Data)
        #print(i " " Data)
        print(i " " many_stones(Data))
    }
    print("count stones")
    print(many_stones(Data))
}
