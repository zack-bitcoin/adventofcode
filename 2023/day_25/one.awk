function add_to_pairs(a, b){
    Pairs[a] = Pairs[a] " " b
    Pairs[b] = Pairs[b] " " a
}

function size(node, r, Pairs2,       filled, P, s){
    if(node in filled){
        return(r)
    } else {
        filled[node] = 1
        r = r+1
        P = Pairs2[node]
        #print(node " : " P)
        while(match(P, /[a-z]+/)){
            s = substr(P, RSTART, RLENGTH)
            r = size(s, r, Pairs2, filled)
            sub(/[a-z]+/, "", P)
        }
        return(r)
    }
}
function print_pairs(){
    print("print pairs")
    for(i in Pairs){
        print(Pairs[i])
    }
}

{
    s = $0
    split(s, a, ":")
    key = a[1]
    Nodes[key] = 1
    m = split(a[2], b, " ")
    for(i=1; i<=m; i++){
        #print("pair " key " " b[i])
        add_to_pairs(key, b[i])
        Nodes[b[i]] = 1
    }
}
function expand(Pairs,        EP, i, m, j){
    for(i in Pairs){
        m = split(Pairs[i], L, " ")
        for(j=1; j<=m; j++){
            EP = EP";"i " " L[j]
        }
    }
    return(EP)
}
END {
    #print_pairs()
    #Size = size(key, 0, Pairs)
    #print(key)
    #print(Size)
    print_pairs()

    EP = expand(Pairs)
    print(EP)
    m = split(EP, EP2, ";")
    print("many pairs: " m)
    for(i=1; i<=m; i++){
        for(j=1; j<=m; j++){
            for(k=1; k<=m; k++){
                if((!(i == j)) && (!(i == k)) && (!(j == k))){
                    EP3 = build_pairs2(i, j, k, EP2, m)
                    print(EP3)
                    #print(size2(EP3))
                }
            }
        }
    }
}

function build_pairs2(a, b, c, EP, m,      i){
    r = ""
    for(i = 0; i<=m; i++){
        if((!(i ==a)) && (!(i == b)) && (!(i ==c))){
            r = r ";" EP[i]
        }
    }
    return(r)
}


function build_pairs(a, b, c, Pairs2,      i){
    for(i in Pairs){
        if((i == a) || (i == b) || (i == c)){
            delete Pairs2[i]
        } else {
            Pairs2[i] = Pairs[i]
        }
    }
}

function build(a, b, c, Nodes2,       i){
    for(i in Nodes){
        if((i == a) || (i == b) || (i == c)){
            delete Nodes2[i]
        } else {
            Nodes2[i] = 1
        }
    }
}
