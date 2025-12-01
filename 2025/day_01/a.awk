BEGIN {
    position = 50
    acc = 0
}
{
    letter = substr($0, 1, 1)
    distance = substr($0, 2)
    position0 = position
    acc0 = acc
    if(letter == "L"){
        position = (position - distance + 100) % 100
    } else if(letter == "R"){
        position = (position + distance + 100) % 100
    }
    if((acc0 == acc) && (position == 0)){
        acc += 1
    }
    #print("position " position " acc " acc)
}
END {

    #print(position)
    print(acc)
}
