function w2p(n){
    if(n < 0){
        print("w2p error")
        return(0)
    }
    if(n==0){
        return(0)
    } else if(n==1){
        return(1)
    } else {
        return(2*w2p(n-1))
    }
}
function is_in(x, winning_numbers){
    return(winning_numbers ~ (" " x " "))
}

function winners(your_numbers, winning_numbers){
    acc = 0
    while(match(your_numbers, /[0-9]+/)){
        yours = substr(your_numbers, RSTART, RLENGTH)
        if(is_in(yours, winning_numbers)){
            acc = acc + 1
        }
        sub(/[0-9]+/, "", your_numbers)
    }
    return acc
}


BEGIN{
    sum = 0
}


{
    split($0, a, ":")
    print(a[2])
    split(a[2], b, "|")
    winning_numbers = b[1]
    your_numbers = b[2]
    w = winners(your_numbers, winning_numbers)
    points = w2p(w)
    sum = sum + points
    print(sum)
}
