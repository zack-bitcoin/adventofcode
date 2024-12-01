
function letter2number(letter){
    if(letter ~ /[2-9]/){
        return(letter+0)
    }
    if(letter == "T"){
        return(10)
    }
    if(letter == "J"){
        return(11)
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
    print("letter2number error " letter)
}
function type(hand,         i, l){
    for(i=1; i<=5; i++){
        l[i] = letter2number(substr(hand, i, 1))
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
