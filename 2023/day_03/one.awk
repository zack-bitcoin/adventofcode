function point_check(ln, col, letter){
    letter = substr(S[ln], col, 1)
    if(length(letter) < 1){
        #print("empty: " letter)
        return(0)
    }
    if(letter ~ /\./){
        #print("period: " letter)
        return(0)
    } else if(letter ~ /[0-9]/){
        #print("digit: " letter)
        return(0)
    } else {
        print("symbol: " letter " at: " ln " " col)
        return(1)
    }
}


function symbol_check(ln, col, is_p){
print("symbol check " ln " " col)
    is_p = 0
    is_p = is_p || point_check(ln-1, col-1)
    is_p = is_p || point_check(ln-1, col)
    is_p = is_p || point_check(ln-1, col+1)

    is_p = is_p || point_check(ln, col-1)
    is_p = is_p || point_check(ln, col+1)

    is_p = is_p || point_check(ln+1, col-1)
    is_p = is_p || point_check(ln+1, col)
    is_p = is_p || point_check(ln+1, col+1)
    return(is_p)

}


BEGIN{
    sum = 0
}
{
    S[NR] = $0
}
END{
    for(ln=1; ln<=NR; ln++){
        s = S[ln]
        while(match(s, /[0-9]+/)){
            #RSTART, RLENGTH
            is_part = 0
            num = substr(s, RSTART, RLENGTH)
            RSTART0 = RSTART
            for(i=0;i<RLENGTH;i++){
                is_part = is_part || symbol_check(ln, RSTART0+i)
            }
            print("num: " num " is part " is_part)
            if(is_part == 1){
                sum += num
            }
            periods = num
            gsub(/[0-9]/, ".", periods)
            sub(num, periods, s)
        }
    }
    print(sum)
}
