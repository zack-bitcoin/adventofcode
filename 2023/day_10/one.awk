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
    Map2[row] = s2
}
function flood(row, col, Map2){
    if(connected(lookup(row-1, col), "down")){
        set_to_S(Map2, row-1, col)
        changed = 1
        Distance[row-1, col] = steps
    }
    if(connected(lookup(row+1, col), "up")){
        set_to_S(Map2, row+1, col)
        changed = 1
        Distance[row+1, col] = steps
    }
    if(connected(lookup(row, col+1), "left")){
        set_to_S(Map2, row, col+1)
        changed = 1
        Distance[row, col+1] = steps
    }
    if(connected(lookup(row, col-1), "right")){
        set_to_S(Map2, row, col-1)
        changed = 1
        Distance[row, col-1] = steps
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
    

{
    Map[NR] = $0
}
/S/ {
    match($0, /S/)
    cols = length($0)
}

END {
    steps = 0
    changed = 1
    print(flood_loop(Map))
    #print_map(Map)
    print(steps-1)
}

#too low 797
#too low 798
