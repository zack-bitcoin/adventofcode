#23:49


BEGIN{
}

/\[/ {
    ManyLines += 1
    Lines[ManyLines] = $0
}

/ 1   2   3 / {
    if(length($0) == 35){
        cols = 9
    } else if (length($0) == 11){
        cols = 3
    }
    for(i = ManyLines; i>= 1; i--){
        for(j = 1; j<= cols; j++){
            x = substr(Lines[i], (4*j)-2, 1)
            if(!(x == " ")){
                stacks[j] = x stacks[j]
            }
        }
    }
}

/move/ {
    s = $0
    match(s, /[0-9]+/)
    many_to_move = substr(s, RSTART, RLENGTH)
    s = substr(s, RSTART + RLENGTH)
    match(s, /[0-9]+/)
    from = substr(s, RSTART, RLENGTH)
    s = substr(s, RSTART + RLENGTH)
    match(s, /[0-9]+/)
    to = substr(s, RSTART, RLENGTH)

    move(many_to_move, from, to)

}

function move(many, from, to){
    if(many == 0) {
        return(0)
    }
    fs = stacks[from]
    if(fs == ""){
        return(0)
    }
    ts = stacks[to]

    t = substr(fs, 1, 1)

    stacks[from] = substr(fs, 2)
    stacks[to] = t ts
    print("s " ts " " fs)
    return(move(many-1, from, to))
}

END {
    for(i=1; i<=10; i++){
        print(substr(stacks[i], 1, 1))
    }    
}
