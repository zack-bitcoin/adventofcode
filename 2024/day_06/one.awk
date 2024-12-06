function walk(row, col, direction, steps,      l){
    #print("walk " row " " col " " direction)
    if(((row+0 < 1) || ((row+0) > NR)) ||
       ((col+0 < 1) || (col+0 > cols+0))){
        print("out of bounds " row " " col)
        print(row+0 < 1)
        print(col+0 < 1)
        print(col+0 < cols+0)
        return(0)
    }
    visited[row, col] = 1
    if(direction == "up"){
        l = substr(Map[row-1], col, 1)
        if(l == "#"){
            return(walk(row, col, "right", steps+1))
        } else {
            return(walk(row-1, col, direction, steps+1))
        }
    }
    if(direction == "right"){
        l = substr(Map[row], col+1, 1)
        if(l == "#"){
            return(walk(row, col, "down", steps+1))
        } else {
            return(walk(row, col+1, direction, steps+1))
        }
    }
    if(direction == "down"){
        l = substr(Map[row+1], col, 1)
        if(l == "#"){
            return(walk(row, col, "left", steps+1))
        } else {
            return(walk(row+1, col, direction, steps+1))
        }
    }
    if(direction == "left"){
        l = substr(Map[row], col-1, 1)
        if(l == "#"){
            return(walk(row, col, "up", steps+1))
        } else {
            return(walk(row, col-1, direction, steps+1))
        }
    }
}


{
    Map[NR] = $0
}
/\^/ {
    start_row = NR
    cols = length($0)
    for(i=1; i<= cols; i++){
        l = substr($0, i, 1)
        if(l == "^"){
            start_col = i
        }
    }
}
END{
    print("start " start_row " " start_col)
    print(NR " " cols)
    visited[start_row, start_col] = 1
    walk(start_row, start_col, "up", 0)
    sum = 0
    for(i=1; i<=NR; i++){
        s = ""
        for(j=1; j<=cols; j++){
            if(visited[i, j] == 1){
                sum+= 1
                s = s "X"
            } else {
                s = s "."
            }
        }
        print(s)
    }
    print(sum)
}
