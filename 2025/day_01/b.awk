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
        clicks_down(distance)
    } else if(letter == "R"){
        clicks_up(distance)
    }
    #print("position " position " acc " acc)
}

function clicks_up(x){
    if(x == 0){ return(0)}
    position += 1
    position = (100 + position) % 100
    if(position == 0){
        acc += 1
    }
    return(clicks_up(x - 1))
}
function clicks_down(x){
    if(x == 0){ return(0)}
    position -= 1
    position = (100 + position) % 100
    if(position == 0){
        acc += 1
    }
    return(clicks_down(x - 1))
}

END {

    #print(position)
    print(acc)
}
