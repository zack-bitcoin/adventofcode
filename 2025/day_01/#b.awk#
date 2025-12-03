BEGIN {
    position = 50
    acc = 0
}
{
    letter = substr($0, 1, 1)
    distance = substr($0, 2)
    direction = 1
    if(letter == "L"){
        direction = -1
    }
    clicks(distance, direction)
}
function clicks(x, n,        i){
    if(x > 99){
        acc += 1
        return(clicks(x-100, n))
    }
    if(x == 0){ return(0)}
    position += n
    position = (100 + position) % 100
    if(position == 0){
        acc += 1
    }
    return(clicks(x-1, n))
}

END {
    #print(position)
    print(acc)
}
