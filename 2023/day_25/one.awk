function add_to_pairs(a, b){
    Pairs[a] = Pairs[a] " " b
    Pairs[b] = Pairs[b] " " a
}

function size(node, r, Pairs2,       filled, P, s){
    #print("size")
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
function print_pairs(Pairs){
    print("print pairs")
    for(i in Pairs){
        print(i ": " Pairs[i])
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
function compress(EP, compressed,     m, i, a, EP2) {
    m = split(EP, EP2, ";")
    for(i = 1; i <= m; i++){
        split(EP2[i], a, " ")
        if(!(match(compressed[a[1]], a[2]))){
            compressed[a[1]] = compressed[a[1]] " " a[2]
        }
    }
}
function expand(Pairs,        EP, i, m, j, L){
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
    Size = size(key, 0, Pairs)
    print(key)
    print(Size)
    print_pairs(Pairs)

    EP = expand(Pairs)
    gsub(/^;/, "", EP)
    print(EP)
    m = split(EP, EP2, ";")
    print("many pairs: " m)
    #Pairs = 1
    for(i=1; i<=m; i++){
        print("count " i)
        for(j=1; j<=m; j++){
            for(k=1; k<=m; k++){
                if((!(i == j)) && (!(i == k)) && (!(j == k))){
                    EPClean = clean_ep(i, j, k, EP, EP2, m)
                    #print("epiclean : " EPClean )
                    n = split(EPClean, EP2b, ";")
                    #print("n is " n )
                    EP3 = build_pairs3(EP2b, n)
                    #EP3 = build_pairs2(i, j, k, EP2, m)
                    #print("ep3: " EP3)
                    gsub(/^;/, "", EP3)
                    gsub(/;+/, ";", EP3)
                    #print("ep3 :" EP3)
                    if(match(EP3, /[a-z][a-z][a-z]/)){
                        starting_node = substr(EP3, RSTART, RLENGTH)
                        compress(EP3, Pairs2)
                    
                        #print("starting node:" starting_node":" EP2[i] " " EP2[j] " " EP2[k])
                        #print("size is: " size(starting_node, 0, Pairs2) " vs " Size)
                        Size2 = size(starting_node, 0, Pairs2)
                        if((Size2 < Size)){
                            print(starting_node ":" EP2[i] "," EP2[j] "," EP2[k])
                            print(Size2 * (Size - Size2))
                            Pairs = 1
                        }
                    } else {
                        print("impossible error: " EP3)
                        Pairs = 1
                    }
                }
            }
        }
    }
}

function clean_ep(a, b, c, EP, EP2, m,      i, r){
    bad1 = EP2[a]
    split(bad1, b1, " ")
    bad1b = b1[2] " " b1[1]
    bad2 = EP2[b]
    split(bad2, b2, " ")
    bad2b = b2[2] " " b2[1]
    bad3 = EP2[c]
    split(bad3, b3, " ")
    bad3b = b3[2] " " b3[1]
#print("clean ep " bad1 ":" bad1b ":"bad2 ":" bad2b ":"bad3 ":" bad3b "_" a " " b " " c "_" EP2[a])
    gsub(bad1 ";", "", EP)
    gsub(bad1b ";", "", EP)
    gsub(bad2 ";", "", EP)
    gsub(bad2b ";", "", EP)
    gsub(bad3 ";", "", EP)
    gsub(bad3b ";", "", EP)
    return(EP)
}
function build_pairs3(EP, m,       r, i) {
    r = ""
    for(i = 1; i<=m; i++){
        r = r ";" EP[i]
    }
    return(r)

}

function build_pairs2(a, b, c, EP, m,      i, r){
    r = ""
    for(i = 1; i<=m; i++){
        if((!(i ==a)) && (!(i == b)) && (!(i ==c))){
            #print("build pairs epi " EP[i])
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
