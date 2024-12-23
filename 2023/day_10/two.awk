function connected(letter, direction){
    if(letter == "F"){
        if((direction == "right") || (direction == "down")){
            return(1)
        } else {
            return(0)
        }
    }
    if(letter == "7"){
        if((direction == "left") || (direction == "down")){
            return(1)
        } else {
            return(0)
        }
    }
    if(letter == "J"){
        if((direction == "left") || (direction == "up")){
            return(1)
        } else {
            return(0)
        }
    }
    if(letter == "L"){
        if((direction == "right") || (direction == "up")){
            return(1)
        } else {
            return(0)
        }
    }
    if(letter == "|"){
        if((direction == "down") || (direction == "up")){
            return(1)
        } else {
            return(0)
        }
    }
    if(letter == "-"){
        if((direction == "right") || (direction == "left")){
            return(1)
        } else {
            return(0)
        }
    }
    return(0)
}

function lookup(row, col){
    if(row<1){return(".")}
    if(row>NR){return(".")}
    if(col<1){return(".")}
    if(col>cols){return(".")}
    return(substr(Map[row], col, 1))
}
function set_to_S(Map2, row, col){
    s = Map2[row]
    s2 = substr(s, 1, col-1) "S" substr(s, col+1, cols - col + 1)
    Distance[row, col] = steps
    Map2[row] = s2
}
function flood(row, col, Map2){
    if(connected(lookup(row-1, col), "down")){
        set_to_S(Map2, row-1, col)
        changed = 1
    }
    if(connected(lookup(row+1, col), "up")){
        set_to_S(Map2, row+1, col)
        changed = 1
    }
    if(connected(lookup(row, col+1), "left")){
        set_to_S(Map2, row, col+1)
        changed = 1
    }
    if(connected(lookup(row, col-1), "right")){
        set_to_S(Map2, row, col-1)
        changed = 1
    }
}

function flood_fill(Map,        Map2, i, j, v, l){
    changed = 0
    for(i=1; i<=NR; i++){
        Map2[i] = Map[i]
    }
    for(i=1; i<=NR; i++){
        v = Map[i]
        for(j=1; j<=cols; j++){
            l = substr(v, j, 1)
            if(l == "S"){
                last_i = i
                last_j = j
                flood(i, j, Map2)
            }
        }
    }
    for(i=1; i<=NR; i++){
        Map[i] = Map2[i]
    }
    if(changed){
        return(last_i " " last_j)
    } else { return(0)}
}
function print_map(Map){
    for(i=1; i<=NR; i++){
        print(Map[i])
    }

}
function flood_loop(Map,     prev_r, r){
    steps++
    r = flood_fill(Map)
    if(r == 0){return(prev_r)}
    return(flood_loop(Map, r))
}
function DrawDistances(       line, d, i, j){
    for(i=1; i<=cols; i++){
        line = ""
        for(j=1; j<=NR; j++){
            d = Distance[i, j]
            if(d){
                line = line " " d
            } else {
                line = line " ."
            }
        }
        print(line)
    }
}
    

{
    Map[NR] = $0
}
/S/ {
    match($0, /S/)
    cols = length($0)
}
function reverse(l,      a, r){
    #test this
    m = split(l, a, ";")
    for(i=1; i<=m; i++){
        b[i] = a[m-i+1]
    }
    r = b[1]
    for(i=2; i<=m; i++){
        r = r "; " b[i] 
    }
    return(r)
}
function combine_loops(l1, l2,      r){
    print("combine loops")
    print(l1)
    print(l2)
    r = reverse(l2)
    print(r)
    sub(/ ?[0-9]+ [0-9]+;/, "", l1)
    sub(/ ?[0-9]+ [0-9]+;/, "", r)
    return(l1 " ;" r)
}
function calculate_loop0(start_row, start_col, many, step, acc,      a, b){
    print("calculate loop0")
    a = calculate_loop(start_row+1, start_col, many, step+1, acc)
    b = calculate_loop(start_row, start_col-1, many, step+1, acc)
    #b = calculate_loop(start_row, start_col+1, many, step+1, acc)
    return(combine_loops(a, b))
}
    
function calculate_loop(start_row, start_col, many, step, acc,     up, down, right, left){
    up = Distance[start_row-1, start_col]
    down = Distance[start_row+1, start_col]
    right = Distance[start_row, start_col+1]
    left = Distance[start_row, start_col-1]
    if(step == many){
        return(acc)
    }
    if(up == step){
        return(calculate_loop(start_row-1, start_col, many, step+1, acc "; " start_row-1 " "start_col))
    } else if(right == step){
        return(calculate_loop(start_row, start_col+1, many, step+1, acc "; " start_row " "start_col+1))
    } else if(down == step){
        return(calculate_loop(start_row+1, start_col, many, step+1, acc "; " start_row+1 " "start_col))
    } else if(left == step){
        return(calculate_loop(start_row, start_col-1, many, step+1, acc "; " start_row " "start_col-1))
    }

}

END {
    steps = 0
    changed = 1
    for(i=1; i<=cols; i++){
        for(j=1; j<=NR; j++){
            letter = substr(Map[j], i, 1)
            if(letter == "S"){
                start_row = j
                start_col = i
            }
        }
    }
    print(flood_loop(Map))
    print(steps-1)#took one extra step to realize that the map was full.
    print("draw distances")
    for(i=1; i<=cols; i++){
        for(j=1; j<=NR; j++){
            letter = Distance[j, i]
            if(letter == (steps-1)){
                end_row = j
                end_col = i
            }
        }
    }
    print("start: " start_row " " start_col)
    print("end: " end_row " " end_col)
    DrawDistances()
    loop = calculate_loop0(start_row, start_col, steps-1, 1,
                           start_row " " start_col)

}

#too low 797
#too low 798
