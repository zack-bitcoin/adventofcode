function loop_file_file(s, p1, id1, p2, id2, pm){
    n1 = substr(s, p1, 1)
    n2 = substr(s, p2, 1)
    for(i=1; i<=n1; i++){
        Memory[pm] = id1
        pm += 1
    }
    loop_space_file(s, p1 + 1, id1 + 1, p2, id2, pm)
}
function loop_space_file(s, p1, id1, p2, id2, pm){
    if(p1 >= p2){
        return(0)
    }
    n1 = substr(s, p1, 1)
    n2 = substr(s, p2, 1)
    #looking for the first space big enough to hold n2, or, looking for the last file that fits in a space of n1
    x = last_file_that_fits(s, n1, p2, p1)
    if(x == "none"){
        for(i=0; i<n1; i++){
            Memory[pm] = "."
            pm += 1
        }
        return(loop_file_file(s, p1+1, id1, p2, id2, pm))
    } else {
        split(x, y, " ")
        id = y[1]
        len = y[2]
        loc = y[3]
        for(i=0; i<len; i++){
            Memory[pm] = id
            pm++
        }
        s = substr(s, 1, loc-1) "0" len "0" substr(s, loc+1, length(s))
        return(loop_space_file(s, p1+2, id1, p2+2, pm))
    }
}


{
    print("line")
    s = $0
    step = "file"
    slot = 0
    start_id = 0
    end_id = int(length(s) / 2)

    p1 = 1
    p2 = length(s)
    loop_file_file(s, p1, start_id, p2, end_id, 1)
}