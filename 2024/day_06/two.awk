function walk(row, col, direction, steps,      l){
    #print("walk " row " " col " " direction)
    if(steps > MAX_LOOPS){
        return(MAX_LOOPS)
    }
    visited[row, col] = 1
    if(((row+0 < 1) || ((row+0) > NR)) ||
       ((col+0 < 1) || (col+0 > cols+0))){
        #print("out of bounds " row " " col)
        #print(row+0 < 1)
        #print(col+0 < 1)
        #print(col+0 < cols+0)
        return(steps)
    }
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

BEGIN {
    MAX_LOOPS = 50000
}

{
    Map[NR] = $0
    visited[-1,-1] = 2
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
    walk(start_row, start_col, "up", 0)
    for(i=1; i<=NR; i++){
        for(j=1; j<=cols; j++){
            visited_original[i, j] = visited[i, j]
        }
    }
    print("start " start_row " " start_col)
    print(NR " " cols)
    for(i=1; i<=NR; i++){
        print("is " i "/" NR)
        for(j=1; j<=cols; j++){
            if((visited_original[i, j] == 1) && (substr(Map[i], j, 1) == ".")){
                Map[i] = substr(Map[i], 1, j-1) "#" substr(Map[i], j+1, length(Map[i]) - j)
                if(walk(start_row, start_col, "up", 0) == MAX_LOOPS){
                    sum+= 1
                    print("loop " i " " j)
                }
                Map[i] = substr(Map[i], 1, j-1) "." substr(Map[i], j+1, length(Map[i]) - j)
            } 
        }
    }
    print(sum)
}
