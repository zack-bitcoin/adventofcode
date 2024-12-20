/,/ {
    many_inputs = split($0, available, ", ")
}

/[brwgu]/ {
    Line[NR-2] = $0
}


END {
    many = NR - 2
    print(available[1] " " available[many])
    for(i=1; i<=many; i++){
        print("line " i)
        if(possible(Line[i])){
            sum += 1
        }
    }
    print(sum)
}

function possible(l,     reg, r, i, l2){
    #print("possible " l)
    if(l in Possible){
        return(Possible[l])
    }
    if(l == ""){
        return(1)
    }

    for(i=1; i<=many_inputs; i++){
        reg = "^" available[i]
        #print("possile " l " " reg)
        if(match(l, reg)){
            #print("match " available[i] " " l)
            l2 = l
            sub(available[i], "", l2)
            if(possible(l2)){
                Possible[l] = 1
                return(1)
            }
        }
    }
    Possible[l] = 0
    return(0)
}