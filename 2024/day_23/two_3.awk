{
    split($0, a, "-")
    Nodes[a[1]] = 1
    Nodes[a[2]] = 1
    Connected[a[1], a[2]] = 1
    Connected[a[2], a[1]] = 1
}
END{
    for(i in Connected){
        sum+=1
    }
    print(sum)
}
function has_t(s){
    return((substr(s, 1, 1) == "t"))
}

