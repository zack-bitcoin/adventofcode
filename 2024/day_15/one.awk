BEGIN {
    row = 0
}

/#/ {
    row += 1
    s = $0
    cols = length(s)
    for(i=1; i<=cols; i++){
        Map[row, i] = substr(s, i, 1)
    }
}

/^/ {
    directions = directions $0
}

/@/ {
    robo_row_start = row
    for(i=1; i<=cols; i++){
        if(substr($0, i, 1) == "@"){
            robo_col_start = i
        }
    }
}

function display(robo_row, robo_col,       i, s, j) {
    print("display")
    for(i=1; i<=rows; i++){
        s = ""
        for(j=1; j<=cols; j++){
            char = Map[i, j]
            if((i == robo_row) && (j == robo_col)){
                s = s "@"
            } else if(char == "@"){
                s = s "."
            } else {
                s = s Map[i, j]
            }
        }
        print(s)
    }
}
function robo_step(path, row, col, drow, dcol){
    row2 = row + drow
    col2 = col + dcol
    spot = Map[row2, col2]
    if(spot == "."){
        
    }
}
function robo_walk(path, row, col,       step, drow, dcol, spot, p){
    #print("robo walk")
    #display(row, col)
    #print("")
    Map[row, col] = "."
    if(path == ""){
        #print("done walking")
        return(0)
    }
    step = substr(path, 1, 1)
    drow = 0
    dcol = 0
    if(step == "<"){
        dcol = -1
    } else if(step == "^"){
        drow = -1
    } else if(step == ">"){
        dcol = 1
    } else if(step == "v"){
        drow = 1
    }
    spot = Map[row + drow, col+dcol]
    if(spot == "#"){
    } else if(spot == "."){
        row = row+drow
        col = col+dcol
    } else if(spot == "O"){
        p = pushable(row+drow, col+dcol, drow, dcol)
        if(p){
            push(row+drow, col+dcol, drow, dcol)
            row = row+drow
            col = col+dcol
        }
    }
    return(robo_walk(substr(path, 2, length(path)), row, col))
}
function pushable(row, col, drow, dcol){
    if(!(Map[row, col] == "O")){
        print("pushable failure 2")
        return(-1000)
    }
    spot = Map[row + drow, col+dcol]
    if(spot == "."){ return(1)}
    if(spot == "O"){ return(pushable(row+drow, col+dcol, drow, dcol))}
    if(spot == "#"){ return(0)}
    print("pushable failure " row " " col " " drow " " dcol)
    return(-1000)
}
function push(row, col, drow, dcol){
    if(!(Map[row, col] == "O")){
        print("push failure")
        return(-1000)
    }
    spot = Map[row + drow, col+dcol]
    if(spot == "."){
        Map[row+drow, col+dcol] = "O"
    } else if (spot == "O"){
        return(push(row+drow, col+dcol, drow, dcol))
    } else if (spot == "#"){
        print("push failure")
        return(-1000)
    }
}

function gps_sum(      sum, i, j){
    print("gps sum")
    sum = 0
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            if(Map[i, j] == "O"){
                #print("found a box")
                sum = sum + ((100 * (i-1)) + (j-1))
            }
        }
    }
    return(sum)
}


END {
    s = directions
    rows = row
    robo_walk(s, robo_row_start, robo_col_start)
    display()
    sum = gps_sum()
    print(sum)
}
