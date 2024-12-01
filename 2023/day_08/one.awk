BEGIN{
    trip = "[A-Z0-9][A-Z0-9][A-Z0-9]"

}

/LRRLRRLLRRR/ {
    path = $0
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


END {
    for(x in N){
        print(x ": " N[x])
    }
}
