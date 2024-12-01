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
    multiplier[NR] += 1
    split($0, a, ":")
    split(a[2], b, "|")
    winning_numbers = b[1]
    your_numbers = b[2]
    w = winners(your_numbers, winning_numbers)
    print("w: " w " " NR)
    for(i=NR+1; i<=NR+w; i++){
        multiplier[i]+=multiplier[NR]
    }
    sum = sum + multiplier[NR]
    print("sum: " sum)
}
