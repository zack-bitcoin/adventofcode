
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

function minimum(a, b){
    if(a < b) {return(a)}
    else {return(b)}
}

