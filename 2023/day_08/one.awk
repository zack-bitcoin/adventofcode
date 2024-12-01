BEGIN{
    trip = "[A-Z0-9][A-Z0-9][A-Z0-9]"
    read_path = true
}

/RRLRRLL/ {
    if(read_path == true){
        path = $0
        read_path = false
    }
}

/ = / {
    match($0, trip)
    a = substr($0, RSTART, RLENGTH)
    sub(trip, " ", $0)
    match($0, trip)
    left = substr($0, RSTART, RLENGTH)
    sub(trip, " ", $0)
    match($0, trip)
    right = substr($0, RSTART, RLENGTH)
    sub(trip, " ", $0)

    N[a] = left " " right
}
function go(Location, pt, steps){
    while(1 == 1){
        if(pt > length(path)){
            pt = 1
        }
        AB = N[Location]
        A = substr(AB, 1, 3)
        B = substr(AB, 5, 3)
        direction = substr(path, pt, 1)
        if(direction == "L"){
            Location = A
        } else {
            Location = B
        }
        pt += 1
        steps += 1
        if(Location == "ZZZ"){
            return(steps)
        }
    }
}


END {
    start = "AAA"
    print(go(start, 1, 0))
}
