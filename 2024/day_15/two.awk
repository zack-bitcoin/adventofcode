function widen(map0, map1){
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            c1 = map0[i, j]
            if(c1 == "#"){
                map1[i, j*2 -1] = "#"
                map1[i, (j*2)] = "#"
            } else if (c1 == "O"){
                map1[i, j*2 -1] = "["
                map1[i, (j*2)] = "]"
            } else if (c1 == "."){
                map1[i, j*2 - 1] = "."
                map1[i, (j*2)] = "."
            } else if (c1 == "@"){
                map1[i, j*2 - 1] = "@"
                map1[i, (j*2)] = "."
            }
        }
    }
    cols = cols * 2 
}

function display(robo_row, robo_col,       i, s, j) {
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
function robo_walk(path, row, col){
    Map[row, col] = "."
    if(path == ""){
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
    } else if((spot == "[") || (spot == "]")){
        p = pushable(row+drow, col+dcol, drow, dcol)
        if(p){
            push(row+drow, col+dcol, drow, dcol)
            row = row+drow
            col = col+dcol
        }
    }
    return(robo_walk(substr(path, 2, length(path)), row, col))
}
function pushable(row, col, drow, dcol,      spot, spot2){
    if(Map[row, col] == "]"){
        #0 indice is the left side of the box.
        return(pushable(row, col-1, drow, dcol))
    }
    if(drow == 0){ #moving left to right can only touch one other box.
        spot = Map[row, col-1]
        spot2 = Map[row, col+2]
        if((dcol == -1) && (spot == ".")){return(1)}
        if((dcol == 1) && (spot2 == ".")){return(1)}
        if((dcol == -1) && (spot == "]")){
            return(pushable(row+drow, col-2, drow, dcol))
        }
        if((dcol == 1) && (spot2 == "[")){
            return(pushable(row, col+2, drow, dcol))
        }
        if((dcol == -1) &&(spot == "#")){return(0)}
        if((dcol == 1) &&(spot2 == "#")){return(0)}
        return(-1000)
    } else if(dcol == 0){ #moving up/down can touch 2 other boxes.
        spot = Map[row+drow, col+dcol]
        spot2 = Map[row+drow, col+dcol+1]
        if((spot == ".") && (spot2 == ".")){ return(1)}
        if((spot == "#") || (spot2 == "#")){return(0)}
        if((spot == ".")){return(pushable(row+drow, col+dcol+1, drow, dcol))}
        if((spot2 == ".")){return(pushable(row+drow, col+dcol, drow, dcol))}
        return(pushable(row+drow, col+dcol+1, drow, dcol) &&
               pushable(row+drow, col+dcol, drow, dcol))
    }
}
function push(row, col, drow, dcol){
    if(Map[row, col] == "]"){
        #0 indice is the left side of the box.
        return(push(row, col-1, drow, dcol))
    }
    if(!(Map[row, col] == "[")){
        return(0)
    }
    spot = Map[row + drow, col+dcol]
    if(drow == 0){ #moving left to right can only touch one other box
        spot2 = Map[row, col+2]
        if((dcol == -1) && (spot == ".")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            Map[row+drow, col+dcol] = "["
            Map[row+drow, col+dcol+1] = "]"
        } else if((dcol == 1) && (spot2 == ".")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            Map[row+drow, col+dcol] = "["
            Map[row+drow, col+dcol+1] = "]"
        } else if((dcol == -1) && (spot == "]")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            push(row, col-2, drow, dcol)
            Map[row, col-1] = "["
            Map[row, col] = "]"
        } else if((dcol == 1) && (Map[row, col+2] == "[")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            push(row, col+2, drow, dcol)
            Map[row, col+1] = "["
            Map[row, col+2] = "]"
        }
    } else if(dcol == 0){ #moving up/down can touch 2 other boxes.
        spot2 = Map[row+drow, col+dcol+1]
        if((spot == ".") && (spot2 == ".")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            Map[row+drow, col+dcol] = "["
            Map[row+drow, col+dcol+1] = "]"
        }else if((spot == ".")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            push(row+drow, col+1, drow, dcol)
            Map[row + drow, col] = "["
            Map[row + drow, col+1] = "]"
        }else if((spot2 == ".")){
            Map[row, col] = "."
            Map[row, col+1] = "."
            push(row+drow, col, drow, dcol)
            Map[row + drow, col] = "["
            Map[row + drow, col+1] = "]"
        } else {
        Map[row, col] = "."
        Map[row, col+1] = "."
        push(row+drow, col, drow, dcol)
        push(row+drow, col+1, drow, dcol)
        Map[row + drow, col] = "["
        Map[row + drow, col+1] = "]"
        }
    }
}
function gps_sum(){
    #print("gps sum")
    sum = 0
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            if(Map[i, j] == "["){
                sum = sum + ((100 * (i-1)) + (j-1))
            }
        }
    }
    return(sum)
}


BEGIN {
    row = 0
}

/#/ {
    row += 1
    s = $0
    cols = length(s)
    for(i=1; i<=cols; i++){
        Map0[row, i] = substr(s, i, 1)
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

END {
    rows = row
    widen(Map0, Map)
    robo_col_start = robo_col_start*2 - 1
    #display(robo_row_start, robo_col_start)
    robo_walk(directions, robo_row_start, robo_col_start)
    #display()
    sum = gps_sum()
    print(sum)
}
