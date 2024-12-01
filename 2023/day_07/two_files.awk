function letter2number(letter){
    if(letter ~ /[2-9]/){
        return(letter+0)
    }
    if(letter == "T"){
        return(10)
    }
    if(letter == "0"){
        return(0)
    }
    if(letter == "J"){
        return(0)
    }
    if(letter == "Q"){
        return(12)
    }
    if(letter == "K"){
        return(13)
    }
    if(letter == "A"){
        return(14)
    }
    if(letter == "10"){
        return(10)
    }
    if(letter == "11"){
        return(11)
    }
    print("letter2number error " letter)
}


function biggest(l,      max, i){
    max = 0
    for(i=1; i<=5; i++){
        if(l[i]>max){
            max = l[i]
        }
    }
    return(max)
}
function maximum(a, b){
    if(a > b) {return(a)}
    return(b)
}
function most_common_biggest(l, t){
    #input already sorted.
    if(t > 3){
        if(l[3] == 0){
            return(14)
        }
        return(l[3])
    } else if(t == 3){
        #two pair
        return(maximum(l[2], l[4]))
    } else if(t == 2){
        #one pair
        if(l[1] == l[2]){
            return(l[1])
        }
        if(l[2] == l[3]){
            return(l[2])
        }
        if(l[3] == l[4]){
            return(l[3])
        }
        if(l[4] == l[5]){
            return(l[4])
        }
    } else {
        return(biggest(l))
    }
}
function replace_js(l, x,      i) {
    for(i=1; i<=5; i++){
        if(l[i] == 0){
            l[i] = x
        }
    }
}
function type(hand,         t, i, l){
    for(i=1; i<=5; i++){
        l[i] = letter2number(substr(hand, i, 1))
    }
    sort5(l)
    t = type2(l)
    sort5(l)
    mcb = most_common_biggest(l, t)
    replace_js(l, mcb)
    return(type2(l))
}

function type2(hand,         i, l){
    for(i=1; i<=5; i++){
        l[i] = letter2number(hand[i])
    }
    sort5(l)
    if((l[1] == l[2])&&(l[1] == l[3]) &&(l[1] == l[4]) &&(l[1] == l[5])){
        #five of a kind
        return(7)
    }
    if((l[1] == l[2])&&(l[1] == l[3]) &&(l[1] == l[4])){
        #four of a kind
        return(6)
    }
    if((l[2] == l[3]) &&(l[2] == l[4]) &&(l[2] == l[5])){
        #four of a kind
        return(6)
    }
    if((l[1] == l[2])&&(l[1] == l[3])&&(l[4] == l[5])){
        #full house
        return(5)
    }
    if((l[1] == l[2])&&(l[4] == l[3])&&(l[4] == l[5])){
        #full house
        return(5)
    }
    if((l[1] == l[2])&&(l[1] == l[3])){
        #three of a kind
        return(4)
    }
    if((l[4] == l[3])&&(l[2] == l[3])){
        #three of a kind
        return(4)
    }
    if((l[4] == l[3])&&(l[5] == l[3])){
        #three of a kind
        return(4)
    }
    if((l[1] == l[2])&&(l[3] == l[4])){
        #two pair
        return(3)
    }
    if((l[1] == l[2])&&(l[5] == l[4])){
        #two pair
        return(3)
    }
    if((l[3] == l[2])&&(l[5] == l[4])){
        #two pair
        return(3)
    }
    if((l[1] == l[2])){
        #one pair
        return(2)
    }
    if((l[3] == l[2])){
        #one pair
        return(2)
    }
    if((l[3] == l[4])){
        #one pair
        return(2)
    }
    if((l[5] == l[4])){
        #one pair
        return(2)
    }
    #high card
    return(1)
}
function letter2alphabetical(l){
    if(l == " "){return(" ")}
    if(l == "1"){return("a")}
    if(l == "2"){return("b")}
    if(l == "3"){return("c")}
    if(l == "4"){return("d")}
    if(l == "5"){return("e")}
    if(l == "6"){return("f")}
    if(l == "7"){return("g")}
    if(l == "8"){return("h")}
    if(l == "9"){return("i")}
    if(l == "T"){return("j")}
    if(l == "J"){return("k")}
    if(l == "Q"){return("l")}
    if(l == "K"){return("m")}
    if(l == "A"){return("n")}
    print("letter2alphabetical error |" l "|")
}

function make_alphabetical(s,      n, out, i){
    out = ""
    match(s, /[1-9ATKQJ]+/)
    for(i=0; i<=5; i++){
        n = substr(s, RSTART+i, 1)
        out = out letter2alphabetical(n)
    }
    return(out)
}

function swap_pair(l, n, m,     a, b){
    #l is a hand of 5 cards.
    #n and m swap places to be a little more sorted.
    a = l[n]
    b = l[m]
    if(a+0 > b+0){
        l[n] = b
        l[m] = a
    }
}
function sort5(l){
    #given 5 cards, sorts them form low to high
    swap_pair(l, 1, 2)
    swap_pair(l, 1, 3)
    swap_pair(l, 1, 4)
    swap_pair(l, 1, 5)
    swap_pair(l, 2, 3)
    swap_pair(l, 2, 4)
    swap_pair(l, 2, 5)
    swap_pair(l, 3, 4)
    swap_pair(l, 3, 5)
    swap_pair(l, 4, 5)
}
{
    hands[NR] = $0
}
END {
    #first calculate type for each hand, to save time in sorting.
    for(i=1; i<=NR; i++){
        t = type(hands[i])
        hands[i] = t hands[i]
    }

    for(i=1; i<=NR; i++){
        print(make_alphabetical(hands[i]) " " hands[i])
    }
}
