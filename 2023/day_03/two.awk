
function get_number(row, col){
    print("get number")
    if((col)<1){
        print("trying to read number from out of bounds")
        return(get_number2(0, row, col+1))
    }
    letter = substr(S[row], col-1, 1)
    if(letter ~ /[0-9]/){
        print("letter " letter " " row " " col)
        #print("prev matched")
        return(get_number(row, col-1))
    }
    letter1 = substr(S[row], col, 1)
    if(letter1 ~ /[0-9]/){
        print("matched")
        return(get_number2(letter, row, col))
    } 
    return(1)
}
function get_number2(acc, row, col){
#    print("get number2")
    print(acc)
    letter = substr(S[row], col, 1)
    if(letter ~ /[0-9]/){
        return(get_number2((acc*10)+letter, row, col+1))
    }
    print("get number 2 returns: " acc)
    return(acc)
}
function get_row_number(row, col){
#    print("get row number 0")
    point[1] = point_check(row, col)
    point[2] = point_check(row, col+1)
    point[3] = point_check(row, col+2)

#    print("get row number 1")
    if(point[1] && point[2] && point[3]){
        return(get_number(row, col))
    }
    if(point[1] && point[3]){
        return(get_number(row, col) * get_number(row, col+2))
    }
#    print("get row number 2")
    if(point[1] && point[2]){
        return(get_number(row, col))
    }
    if(point[2] && point[3]){
        return(get_number(row, col+1))
    }
#    print("get row number 3")
    if(point[1]){
        return(get_number(row, col))
    }
    if(point[2]){
        return(get_number(row, col+1))
    }
#    print("get row number 4")
    if(point[3]){
        return(get_number(row, col+2))
    }
    return(1)
}

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
        return(1)
    } else {
        #print("symbol: " letter " at: " ln " " col)
        return(0)
    }
}

function row_count(a, b, c){
    if(a && b && c){return(1)}
    if(a && b){return(1)}
    if(b && c){return(1)}
    if(a && c){return(2)}
    else{
        return(a+b+c)
    }
}

function number_check(row, col){
#    print("number check")
    point[1] = point_check(row-1, col-1)
    point[2] = point_check(row-1, col)
    point[3] = point_check(row-1, col+1)

    point[4] = point_check(row, col-1)
    point[6] = point_check(row, col+1)

    point[7] = point_check(row+1, col-1)
    point[8] = point_check(row+1, col)
    point[9] = point_check(row+1, col+1)
#    print("number check 2")

    many_adjacent = point[4] + point[6] + row_count(point[1], point[2], point[3]) + row_count(point[7], point[8], point[9])

    if(!(many_adjacent == 2)){
        print("not a gear. adjacents: " many_adjacent)
        #print(point[1] " " point[2] " " point[3])
        #print(point[4] " . " point[6])
        #print(point[7] " " point[8] " " point[9])
        return(0)
    }
    gear_ratio = 1
#    print("number check 3")
    n4 = get_number(row, col-1)
    n6 = get_number(row, col+1)
#    print("number check 4")
    r1 = get_row_number(row-1, col-1)
    r3 = get_row_number(row+1, col-1)
#    print("number check 5")

    print("gear values: " gear_ratio " " n4 " " n6 " "r1 " " r3)
    gear_ratio = gear_ratio * n4 * n6 * r1 * r3
    return(gear_ratio)
}



BEGIN{
    sum = 0
}
{
    S[NR] = $0
}
END{
#    print(get_number(1, 6))
#    print(get_number(1, 7))
#    print(get_number(1, 8))
    for(ln=1; ln<=NR; ln++){
        s = S[ln]
        while(match(s, /\*/)){
            print(s)
            GR = number_check(ln, RSTART)
            sum += GR
            sub("*", ".", s)
        }
    }
    print(sum)
}

#too high 177767024
