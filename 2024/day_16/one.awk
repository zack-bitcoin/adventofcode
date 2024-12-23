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
    print(minimum(minimum(a, b), minimum(c, d)))
    #print(distance3(start_y, start_x, direction_y, direction_x, filled))
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
        }
    } else {
        print("adding new element " x " " y)
    }
    distances[y, x, dy, dx] = d
    calc_distances(y+dy, x+dx, dy, dx, d+1, distances)
    calc_distances(y, x, dx, dy, d+1000, distances)
    calc_distances(y, x, -dx, -dy, d+1000, distances)
}

function minimum(a, b){
    if(a < b) {return(a)}
    else {return(b)}
}

