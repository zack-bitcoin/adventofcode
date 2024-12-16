
BEGIN{
    direction_y = 0
    direction_x = 1
}

/E/ {
    cols = length($0)
    for(i=1; i<=length($0); i++){
        s = substr($0, i, 1)
        if(s == "E"){
            end_y = NR
            end_x = i
        }
    }
}
/S/ {
    for(i=1; i<=length($0); i++){
        s = substr($0, i, 1)
        if(s == "S"){
            start_y = NR
            start_x = i
        }
    }
}

{
    for(i=1; i<=length($0); i++){
        Grid[NR, i] = substr($0, i, 1)
    }
}

END{
    print("end")
    calc_distances(start_y, start_x, direction_y, direction_x, 0, distances)
    a = distances[end_y, end_x, 1, 0]
    b = distances[end_y, end_x, -1, 0]
    c = distances[end_y, end_x, 0, 1]
    d = distances[end_y, end_x, 0, -1]
    m = minimum(minimum(a, b), minimum(c, d))
    if(a == m){
        on_best_path(distances, end_y, end_x, 1, 0, best)
    }
    if(b == m){
        on_best_path(distances, end_y, end_x, -1, 0, best)
    }
    if(c == m){
        on_best_path(distances, end_y, end_x, 0, 1, best)
    }
    if(c == m){
        on_best_path(distances, end_y, end_x, 0, -1, best)
    }
    print(count_up(best))
    #print(distance3(start_y, start_x, direction_y, direction_x, filled))
}

function on_best_path(distances, end_y, end_x, dy, dx, best,     D, a, b, c){
    print("on best path")
    best[end_y, end_x] = 1
    D = distances[end_y, end_x, dy, dx]
    a = distances[end_y-dy, end_x-dx, dy, dx]
    if(D-1 == a){
        on_best_path(distances, end_y-dy, end_x-dx, dy, dx, best)
    }
    b = distances[end_y, end_x, dx, dy]
    if(D-1000 == b){
        on_best_path(distances, end_y, end_x, dx, dy, best)
    }
    c = distances[end_y, end_x, -dx, -dy]
    if(D-1000 == c){
        on_best_path(distances, end_y, end_x, -dx, -dy, best)
    }
}
function count_up(x,      i, sum){
    for(i in x){
        sum+= 1
    }
    return(sum)
}



function lookup(y, x, filled,        l){
    if(0){#(y, x) in filled){
        return("#")
    } else {
        l = Grid[y, x]
        return(l)
    }
}
function copy(x,y,      i){
    for(i in y){
        delete y[i]
    }
    for(i in x){
        y[i] = x[i]
    }
}
function display(filled2,         i, s, j){
    for(i=1; i<= NR; i++){
        s = ""
        for(j=1; j<=cols; j++){
            if(filled2[i, j]){
                s = s "X"
            } else {
                s = s " "
            }
        }
        if(match(s, /X/)){
            print(s)
        }
    }
    print("")
}

function calc_distances(y, x, dy, dx, d, distances){
    #print("calc distances " y " " x)
    l = Grid[y, x]
    if(l == "#") {
        return(300000000)
    }
    if((y, x, dy, dx) in distances){
        old = distances[y, x, dy, dx]
        if(old <= d){
            return(old)
        } else {
            #print("new is less " d " " old)
        }
    } else {
        #print("adding new element " x " " y)
    }
    distances[y, x, dy, dx] = d
    calc_distances(y+dy, x+dx, dy, dx, d+1, distances)
    calc_distances(y, x, dx, dy, d+1000, distances)
    calc_distances(y, x, -dx, -dy, d+1000, distances)
}

function distance2(y, x, direction_y, direction_x, filled,     letter, filleda, filledb, filledc, filledd, step, turn1, turn2, turn3, mina, fillede, minb, filledf, minc){
    if((y == end_y) && (x == end_x)){
        return(0)
    }
    letter = lookup(y, x, filled2)
    if(letter == "#"){
        return(300000000000000)
    }
    if((y, x, direction_y, direction_x) in filled){
        return(filled[y, x, direction_y, direction_x])
    }
    print("distance " y " " x " "direction_y " " direction_x)
    filled[y, x, direction_y, direction_x] = 4000000000000000 
    copy(filled, filleda)
    copy(filled, filledb)
    copy(filled, filledc)
    copy(filled, filledd)
    step = distance2(y+direction_y, x+direction_x, direction_y, direction_x, filleda)
    turn1 = distance2(y, x, -direction_y, -direction_x, filledb)
    turn2 = distance2(y, x, direction_x, direction_y, filledc)
    turn3 = distance2(y, x, -direction_x, -direction_y, filledd)

    mina = minimum2(step+1, filleda, turn1+2000, filledb, fillede)
    minb = minimum2(turn2+1000, filleda, turn3+1000, filledb, filledf)
    minc = minimum2(mina, fillede, minb, filledf, filled)

    filled[y, x, direction_y, direction_x] = minc
    return(m)
}


function distance(y, x, dy, dx, filled2,        filleda, filledb, filledc, filledd, letter, front, back, side1, side2, result){
    #print(y, x)
    letter = lookup(y, x, filled2)
    if(letter == "#"){
        return(300000000000000)
    }
    if((y, x) in filled2){
        return(500000000000000)
    }
    filled2[y, x] = 1
    if((y, x, dy, dx) in Cache){
        #display(filled2)
        return(Cache[y, x, dy, dx])
    }
    if((y == end_y) && (x == end_x)){
        print("reached end")
        #display(filled2)
        return(0)
    }
    copy(filled2, filleda)
    copy(filled2, filledb)
    copy(filled2, filledc)
    copy(filled2, filledd)
    #print(y ", " x)
    front = distance(y+dy, x+dx, dy, dx, filleda)
    side1 = distance(y+dx, x+dy, dx, dy, filledc)
    side2 = distance(y-dx, x-dy, -dx, -dy, filledd)
    back = distance(y-dy, x-dx, -dy, -dx, filledb)
    #print(y ", " x)
    #print("4 distances: " front " " back " "side1 " "side2)
    result = minimum(minimum(front+1, back+2001),
                     minimum(side1+1001, side2+1001))
    Cache[y, x, dy, dx] = result
    return(result)
}
function minimum(a, b){
    if(a < b) {return(a)}
    else {return(b)}
}

function minimum2(a, filleda, b, filledb, filled){
    if(a < b){
        copy(filleda, filled)
        return(a)
    } else {
        copy(filledb, filled)
        return(b)
    }
}

#incorrect 178612
#incorrect 290912
#incorrect 290916
#incorrect 269868
