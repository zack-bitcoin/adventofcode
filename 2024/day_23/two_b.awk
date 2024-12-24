{
    trio = $0
}

END{
#    print(trio)

    trio = compress(trio)
    print(trio)
}
function combine(a, b){
    m = split(a, c, " ")
    r = b
    for(i=1; i<=m; i++){
        if(match(b, c[i])){
        } else {
            r = c[i] " " b
        }
    }
    #print("combined " r)
    return(r)
}
function compress(trio){
    split(trio, T, ",")
    print("check if connected")
    done = 0
    for(i in T){
        for(j in T){
            if(i > j){
                if(all_connected(T[i], T[j])){
                    new = combine(T[i], T[j])
                    done = 1
                    break
                }
            }
        }
        if(done){break}
    }
    s = ""
    for(k in T){
        if(k == i){

        } else if(k == j){

        } else {
            s = s ";" T[k]
        }
    }
    print(new)
    s = new ";" s
    return(s)
   # print(sum)
}
function all_connected(a, b,      a2, b2, i, j, m, n){
    #print(a "$" b)
    m = split(a, a2, " ")
    n = split(b, b2, " ")
    for(i = 1; i<=m; i++){
        for(j = 1; j<=n; j++){
            #print(a2[i] "|" b2[j])
            if((!(a2[i] == b2[j])) &&(!((a2[i], b2[j]) in Connected))){
                return(0)
            }
        }
    }
    return(1)
}
function has_t(s){
    return((substr(s, 1, 1) == "t"))
}
