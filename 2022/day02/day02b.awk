function before(x){
    if(x == "A") {
        return("C")
    }
    if(x == "B") {
        return("A")
    }
    if(x == "C") {
        return("B")
    }
}
function after(x){
    if(x == "A") {
        return("B")
    }
    if(x == "B") {
        return("C")
    }
    if(x == "C") {
        return("A")
    }
}

function round_score2(p, q,      s) {
    if(q == "Y"){
        s += 3
    }
    if(q == "Z"){
        s += 6
    }
    if(q == "X"){
        c = before(p)
    } if(q == "Z"){
        c = after(p)
    } if(q == "Y"){
        c = p
    }
    if(c == "A"){
        s+=1
    }
    if(c == "B"){
        s+=2
    }
    if(c == "C"){
        s+=3
    }

    return(s)
}

/[ABC] [XYZ]/ {
    p = substr($0, 1, 1)
    q = substr($0, 3, 1)
    score += round_score2(p, q)
}

END{
    print("final score " score)
}
