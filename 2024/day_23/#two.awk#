#First I looked for pairs that had lots of neighbors in common.
#then out of those pairs, I searched for ones where all the neighbors were connected.



# 520 nodes
# each node has 13 peers
# 3380 connections
# 3081 pairs of nodes share at least 10 neighbors and are connected

function add_to_peers(x, y, a){
    a = Peers[x]
    if (match(a, y)){
        return(0)
    } else {
        Peers[x] = Peers[x] " " y
    }
}
function many_in_common(a, b,      m, c, sum, i){
    m = split(a, c, " ")
    sum = 0
    for(i = 1; i<=m; i++){
        if(match(b, c[i])){
            sum += 1
        }
    }
    return(sum)
}
function many_in_common2(a, b, b2,      m, c, sum, i){
    m = split(a, c, " ")
    sum = 0
    for(i = 1; i<=m; i++){
        if(match(b, c[i]) && match(b2, c[i])){
            sum += 1
        }
    }
    return(sum)
}
function max(a, b){
    if(a > b){return(a)}
    return(b)
}
BEGIN {
    Attempt = "cw,dy,ef,iw,ji,jv,ka,ob,qv,ry,ua,wt,xz"

}
{
    split($0, a, "-")
    Nodes[a[1]] = 1
    Nodes[a[2]] = 1
    Connected[a[1], a[2]] = 1
    Connected[a[2], a[1]] = 1
    add_to_peers(a[1], a[2])
    add_to_peers(a[2], a[1])
}

END{
    print(Peers["ji"])
    print(Peers["dy"])
    m = split(Attempt, A2, ",")
    for(i=1; i<=m; i++){
        print("i is " A2[i] )
        
        print(Peers[A2[i]])
        for(j=1; j<=m; j++){
            if(i < j){
                if(Connected[A2[i], A2[j]]){
                } else {
                    print("NOT CONNECTED" A2[i], A2[j])
                }
            }
        }
    }

    Peers = 0

    r = 0
    sum = 0
    lines = 0
    for(i in Nodes){
        lines += 1
        #print(lines, sum)
        for(j in Nodes){
            if((i > j) && Connected[i, j]){
                mic = many_in_common(Peers[i], Peers[j])
                if(mic > 9){
                    sum += 1
                    print("check " i " " j)
                    if(all_connected2(Peers[i] " " i " " j)){
                        print(Peers[i] ";" Peers[j] ";" i " " j )
                    }
                }
            }
        }
    }
    print(sum)
#    for(i in Nodes){
#        for(j in Nodes){
#            for(k in Nodes){
#                    if((i > j) && (j > k)){
#                        if(((i, j) in Connected) && ((j, k) in Connected) && ((i, k) in Connected)){
#                            if(has_t(i) || has_t(j) || has_t(k)){
#                                trio = trio ", " i " " j " " k
#                                sum+=1
#                            }
#                        }
#                    }
#            }
#        }
#    }
#    trio = substr(trio, 2, length(trio))

#    print(trio) > "trios_file"
    #print(trio)
#    for(i=1; i<=2000; i++){
#        trio = compress(trio)
#    }
#    print(trio)
}
function combine(a, b){
    m = split(a, c, " ")
    r = b
    for(i=1; i<=m; i++){
        if(match(b, c[i])){
        } else {
            r = c[i]" " b
        }
    }
    print("combined " r)
    return(r)
}
function compress(trio,       T, done, i, j, new, s, k){
    split(trio, T, ",")
    print("check if connected")
    done = 0
    for(i in T){
        for(j in T){
            if(i > j){
                print(T[i] "|" T[j])
                if(all_connected(T[i], T[j])){
                    new = combine(T[i], T[j])
                    done = 1
                    break
                }
            }
        }
        if(done){break}
    }
    print("done " done)
    if(done == 0){
        print("none to combine")
        print(trio)
        return(trio)}
    s = ""
    for(k in T){
        if(k == i){

        } else if(k == j){

        } else {
            s = s "," T[k]
        }
    }
    s = new s
    print("new is " new)
    return(s)
   # print(sum)
}
function all_connected2(l,       m, a, r, i, j){
    m = split(l, a, " ")
    r = 1
    for(i=1; i<=m; i++){
        for(j=1; j<i; j++){
            if(a[i] == a[j]){
            } else if(!(Connected[a[i], a[j]])){
                print(a[i] " and " a[j] " do not connect ")
                r = 0
                #return(0)
            } else {
                #print("good")
            }
        }
    }
    return(r)
}
function all_connected(a, b,      a2, b2, i, j, m, n){
    #print(a "$" b)
    m = split(a, a2, " ")
    n = split(b, b2, " ")
    for(i = 1; i<=m; i++){
        for(j = 1; j<=n; j++){
            #print(a2[i] "|" b2[j] "," i " " j)
            if((a2[i] == b2[j])){
            } else if(!((a2[i], b2[j]) in Connected)){
                return(0)
            } else {
                #print("someting was connected " a2[i] "," b2[j])
            }
        }
    }
    return(1)
}
function has_t(s){
    return((substr(s, 1, 1) == "t"))
}

#wrong "cw,dy,ef,ji,jv,ob,qv,ry,ua,wt,xz"
