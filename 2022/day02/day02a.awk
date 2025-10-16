function round_score(p, q,      s) {
    if(q == "X"){
        s += 1
    }
    if(q == "Y"){
        s += 2
    }
    if(q == "Z"){
        s += 3
    }
    
    if((p == "A") && (q == "X")){
        s += 3
    }
    if((p == "B") && (q == "Y")){
        s += 3
    }
    if((p == "C") && (q == "Z")){
        s += 3
    }

    if((p == "A") && (q == "Y")){
        s += 6
    }
    if((p == "B") && (q == "Z")){
        s += 6
    }
    if((p == "C") && (q == "X")){
        s += 6
    }
    print($0 " " s)
    return(s)
}


/[ABC] [XYZ]/ {
    p = substr($0, 1, 1)
    q = substr($0, 3, 1)
    score += round_score(p, q)
}

END{
    print("final score " score)
}
