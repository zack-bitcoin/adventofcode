BEGIN {
    position = 50
    acc = 0
}
{
    letter = substr($0, 1, 1)
    distance = substr($0, 2)
    if(letter == "L"){
        distance = -distance
    }
    position = (position + distance + 100) % 100
    if(position == 0){
        acc += 1
    }
}

END {
    print(acc)
}
