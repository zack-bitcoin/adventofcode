{
    split($0, a, "-")
    Nodes[a[1]] = 1
    Nodes[a[2]] = 1
    Connected[a[1], a[2]] = 1
    Connected[a[2], a[1]] = 1
}

END{
    for(i in Nodes){
        for(j in Nodes){
            for(k in Nodes){
                #if((!(i==j)) && (!(i == k)) && (!(j == k))){
                #if(alph(i, j) && alph(j, k)){
                    if((i > j) && (j > k)){
                        if(((i, j) in Connected) && ((j, k) in Connected) && ((i, k) in Connected)){
                            #if(Connected[i, j] && Connected[j, k] && Connected[i, k]){
                            if(has_t(i) || has_t(j) || has_t(k)){
                                print(k, j, i)
                                sum+=1
                            }
                        }
                    }
            }
        }
    }
    print(sum)
}
function has_t(s){
    return((substr(s, 1, 1) == "t"))
#           (substr(s, 2, 1) == "t"))
}

#wrong 2106
