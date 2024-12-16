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
END {
    Size = size(key, 0, Pairs)
    #print(key)
    print(Size)
    for(i in Pairs){
        for(j in Pairs){
            for(k in Pairs){
                if((!(i == j)) && (!(i == k)) && (!(j == k))){
                    #print("triple")
                    build_pairs(i,j,k, Pairs2)
                    #print("triple size")
                    Size2 = size(key, 0, Pairs2)
                    print("size " Size2)
                    if(Size2 < Size-3){
                        print(i, j, k, Size, Size2, Size2 * (Size - Size2))
                    }
                }
            }
        }
    }
    print(key)
}

function build_pairs(a, b, c, Pairs2,      i){
    for(i in Pairs){
        if((i == a) || (i == b) || (i == c)){
            delete Pairs2[i]
        } else {
            Pairs2[i] = 1
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