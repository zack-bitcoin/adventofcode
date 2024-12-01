
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


function letter_gt_unused(a, b,     n1, n2){
    n1 = letter2number(a)
    n2 = letter2number(b)
    if(0+n1 > n2+0){return(1)}
    if(n1+0 < n2+0){return(0)}
    else{ print("letter gt error")}
}

function by_card_gt_unused(c1, c2,    l1, l2, i){
    for(i=1; i<=5; i++){
        l1 = substr(c1, i, 1)
        l2 = substr(c2, i, 1)
        if(!(l1 == l2)){
            return(letter_gt(l1, l2))
        }
    }
    print("by card gt error " c1 " " c2)
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

function gt_unused(c1, c2,      t1, t2, a1, a2){
    #if something doesn't exist, it is always bigger.
    if(!(c1)){return(1)}
    if(!(c2)){return(0)}

    #unpack the cards into their parts.
    split(c1, a1, " ")
    split(c2, a2, " ")

    #first check if the types are different
    t1 = a1[3]
    t2 = a2[3]
    if(t1+0 < t2+0){
        return(0)
    } else if(t1 > t2){
        return(1)
    } else {
        #types are the same, so compare by card number.
        return(by_card_gt(a1[1], a2[1]))
    }
}

#merging the lists `a` and `b`, result is in `c`
function merge_unused(a, al, #al = length of a
               b, bl,
               c,       i, j, k, cl){
    i=1
    j=1
    k=1
    cl = al + bl
    while(1==1){
        bool = gt(a[i], b[j])
        if(bool){
            c[k] = b[j]
            j += 1
        } else {
            c[k] = a[i]
            i += 1
        }
        k += 1
        if(k > cl+0){
            return(cl)
        }
    }
}


function sort_unused(hands, hl, depth,               a, b, i, a2, b2, half){
    #using a merge sort algorithm.
    if(hl == 2){
        #if there are only 2 cards left, then put them in order.
        a[1] = hands[1]
        b[1] = hands[2]
        return(merge(a, 1, b, 1, hands))
    }
    if(hl < 2){
        #if there are less than 2 cards, then it is already sorted.
        return(hl)
    }
    #cut the input in half
    half = int(hl / 2)
    for(i=1; i<=half; i++){
        a[i] = hands[i]
    }
    for(i=1; i<=hl-half; i++){
        b[i] = hands[half+i]
    }
    #sort the two halves.
    sort(a, half, depth+1)
    sort(b, hl-half, depth+1)
    #then merge them.
    return(merge(a, half, b, hl-half, hands))
}

function convert_word(s,         x, x2, s1, s2, i){
    #print("convert")
    for(i=1; i<=length(s); i++){
        x = substr(s, i, 1)
        x2 = convert(x)
        #print("six " s " " i " " x " " x2)
        s1 = substr(s, 1, i-1)
        s2 = substr(s, i+1, length(s) - i)
        #print("ss " s1 " " s2)
        s = s1 x2 s2
    }
    return(s)
}

function convert(letter){
    if(letter == "1"){
        return("a")
    }
    if(letter == "2"){
        return("b")
    }
    if(letter == "3"){
        return("c")
    }
    if(letter == "4"){
        return("d")
    }
    if(letter == "5"){
        return("e")
    }
    if(letter == "6"){
        return("e")
    }
    if(letter == "7"){
        return("f")
    }
    if(letter == "8"){
        return("g")
    }
    if(letter == "9"){
        return("h")
    }
    if(letter == "T"){
        return("i")
    }
    if(letter == "J"){
        return("j")
    }
    if(letter == "Q"){
        return("k")
    }
    if(letter == "K"){
        return("l")
    }
    if(letter == "A"){
        return("m")
    }
    print("convert error " letter)
}


{
    hands[NR] = $0
}

END {
    #first calculate type for each hand, to save time in sorting.
    result = ""
    for(i=1; i<=NR; i++){
        t = type(hands[i])
        #hands[i] = t hands[i]
        split(hands[i], a, " ")
        #print("before convert " a[1])
        #print("after " convert_word(a[1]))
        result = result "\n" t convert_word(a[1]) " " a[2]
        #print(result)
    }

    print result | "sort -k 1"
    
    #sort(hands, NR, 1)

    #sum up the points
    #sum = 0
    #for(i=1; i<=NR; i++){
    #    split(hands[i], val, " ")
    #    sum += (i * val[2])
    #}
#    print("sorted cards: ")
#    for(i=1; i<=NR; i++){
#        print(hands[i])
#    }
}
