BEGIN{
    trip = "[A-Z0-9][A-Z0-9][A-Z0-9]"
    read_path = 1
}

/LR/ {
    if(read_path == 1){
        path = $0
        read_path = 0
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
function go(Location, pt, steps,         AB, A, B, direction){
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
function all_end_in_z(cards, many_cards, steps,        r, i){
    r = 1
    for(i=1; i<=many_cards; i++){
        #print(cards[i] " " original_starts[i])
        #r=0
        if(substr(cards[i], 3, 1) == "Z"){
            print(i " " cards[i] " " steps)
            #print(path)
        }
        if(!(substr(cards[i], 3, 1) == "Z")){
            r = 0
        } else {
        }
    }
    return(r)
}

# 1 11567
# 2 14257
# 3 19099
# 4 16409
# 5 12643
# 6 21251


function go2(cards, many_cards, pt, steps,      Location, AB, A, B, direction, i){
    print("go2: " many_cards)
    while(1 == 1){
        if(steps > 22000){
            print("ran out of time")
            return(0)
        }
        if(all_end_in_z(cards, many_cards, steps) && (steps > 1)){
            print("all ended in zero")
            return(steps)
        }
        for(i=1; i<= many_cards; i++){
            Location = cards[i]
            AB = N[Location]
            A = substr(AB, 1, 3)
            B = substr(AB, 5, 3)
            direction = substr(path, pt, 1)
            if(direction == "L"){
                cards[i] = A
            } else {
                cards[i] = B
            }
        }
        pt += 1
        steps += 1
        if(pt > length(path)){
            pt = 1
        }
    }

}


END {
    many_starters = 0
    for(i in N){
        s = substr(i, 3, 1)
        if(s == "A"){
            many_starters += 1
            starts[many_starters] = i
        }
    }
    print(go2(starts, many_starters, 1, 0))
}
