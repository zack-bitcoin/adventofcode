{
    split($0, a, "-")
    Nodes[a[1]] = 1
    Nodes[a[2]] = 1
    Connected[a[1], a[2]] = 1
    Connected[a[2], a[1]] = 1
}

END{
    for(i in Nodes){
        s = 0
        for(j in Nodes){
            if((i, j) in Connected){
                s += 1
            }
        }
        print(i " " s)
    }
}
