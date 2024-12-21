#disallowed, numeric_row = 4, numeric_col = 1
#disallowed, direction_row = 1, direction_col = 1
BEGIN {
    numeric_row["7"] = 1
    numeric_row["8"] = 1
    numeric_row["9"] = 1
    numeric_row["4"] = 2
    numeric_row["5"] = 2
    numeric_row["6"] = 2
    numeric_row["1"] = 3
    numeric_row["2"] = 3
    numeric_row["3"] = 3
    numeric_row["0"] = 4
    numeric_row["A"] = 4
    numeric_col["7"] = 1
    numeric_col["8"] = 2
    numeric_col["9"] = 3
    numeric_col["4"] = 1
    numeric_col["5"] = 2
    numeric_col["6"] = 3
    numeric_col["1"] = 1
    numeric_col["2"] = 2
    numeric_col["3"] = 3
    numeric_col["0"] = 2
    numeric_col["A"] = 3

    direction_row["^"] = 1
    direction_row["A"] = 1
    direction_row["<"] = 2
    direction_row["v"] = 2
    direction_row[">"] = 2

    direction_col["^"] = 2
    direction_col["A"] = 3
    direction_col["<"] = 1
    direction_col["v"] = 2
    direction_col[">"] = 3
}


{
    #$0 is the keypad
    kp = keypad_process($0, 3,4)
    # kp is the first robot
    m = split(kp, kpb, ";")
    kp2 = ""
    #kp2 is the second robot
    for(i=1; i<=m; i++){
        kp2 = kp2 ";" direction_process(kpb[i], 3, 1)
    }
    kp2 = substr(kp2, 2, length(kp2))
    #print("kp2 " kp2)
    m = split(kp2, kp2b, ";")
    kp3 = ""
    min_code = 100000000000000000
    for(i=1; i<=m; i++){
        #print("kp4 " i " " m)
        code = direction_process(kp2b[i], 3, 1)
        n = split(code, code2, ";")
        for(j=1; j<=n; j++){
            if(length(code2[j]) < min_code){
                min_code = length(code2[j])
                kp3 = code2[j]
                kp4 = kp2b[i]
            }
        }
    }
    #print(kp3)
    #print(kp4)
    #print(kpb[3])
    #print($0)
    #print(min_code)
    match($0, /[0-9]+/)
    numeric_part = substr($0, RSTART, RLENGTH)
    #print("numeric :  " numeric_part)
    sum += (min_code * numeric_part)
}

END{
    print(sum)
}

function direction_process(s, keypad_col, keypad_row,     letter, p, i, r){
    #print("direction process")
    r = ""
    for(i=1; i<=length(s); i++){
        letter = substr(s, i, 1)
        p = direction_paths_to(letter, keypad_col, keypad_row)
        keypad_col = direction_col[letter]
        keypad_row = direction_row[letter]
        r = append_paths(r, p)
    }
    return(r)
}
function keypad_process(s, keypad_col, keypad_row,      letter, p, i, r){
    #print("keypad process")
    r = ""
    for(i=1; i<=length(s); i++){
        letter = substr(s, i, 1)
        p = paths_to(letter, keypad_col, keypad_row)
        keypad_col = numeric_col[letter]
        keypad_row = numeric_row[letter]
        #print("keypad process: "p)
        r = append_paths(r, p)
    }
    return(r)
}
function append_paths(ps1, ps2,       m1, m2, i, j, r){
    if(ps1 == ""){return(ps2)}
    if((!ps1) || (!ps2)){
        return(0)
    }
    m1 = split(ps1, p1, ";")
    m2 = split(ps2, p2, ";")
    r = ""
    for(i=1; i<=m1; i++){
        for(j=1; j<=m2; j++){
            r = r ";" p1[i] p2[j]
        }
    }
    return(substr(r, 2, length(r)))
}

function append_step(letter, paths,       i, m, r){
    #print("append step " letter " , " paths)
    if(paths == 0){return(0)}
#    if(!(paths)){return(0)}
    m = split(paths, p, ";")
    r = letter p[1]
    for(i = 2; i<=m; i++){
        r = r ";" letter p[i]
    }
    return(r)
}
function or_paths(a, b){
    if((!a) && (!b)){return(0)}
    if(!a){return(b)}
    if(!b){return(a)}
    return(a ";" b)
}

function direction_paths_to(letter, keypad_col, keypad_row,       case1, case2, times, letters){
    #print("direction paths to " letter, keypad_col, keypad_row)
    if((keypad_row == 1) && (keypad_col == 1)){
        #print("dead path")
         return(0)
    }
    col = direction_col[letter]
    row = direction_row[letter]
    if(row < keypad_row){
        times = keypad_row - row
        letters = repeated("^", times)
        case1 = append_step(letters, direction_paths_to(letter, keypad_col, keypad_row-times))
    } else if (row > keypad_row){
        times = row - keypad_row
        letters = repeated("v", times)
        case1 = append_step(letters, direction_paths_to(letter, keypad_col, keypad_row+times))
    }
    if(col < keypad_col){
        times = keypad_col - col
        letters = repeated("<", times)
        case2 = append_step(letters, direction_paths_to(letter, keypad_col-times, keypad_row))
    } else if (col > keypad_col){
        times = col - keypad_col
        letters = repeated(">", times)
        case2 = append_step(letters, direction_paths_to(letter, keypad_col+times, keypad_row))
    }
    if(case1 && case2){
        return(or_paths(case1, case2))
    }
    if(case1){
        return(case1)
    }
    if(case2){
        return(case2)
    }
    return("A")
}

function paths_to(letter, keypad_col, keypad_row,     case1,case2, col, row){
    if((keypad_row == 4) && (keypad_col == 1)){
        #print("dead path")
         return(0)
    }
    col = numeric_col[letter]
    row = numeric_row[letter]
    if(row < keypad_row){
        case1 = append_step("^", paths_to(letter, keypad_col, keypad_row-1))
    } else if (row > keypad_row){
        case1 = append_step("v", paths_to(letter, keypad_col, keypad_row+1))
    }
    if(col < keypad_col){
        case2 = append_step("<", paths_to(letter, keypad_col-1, keypad_row))
    } else if (col > keypad_col){
        case2 = append_step(">", paths_to(letter, keypad_col+1, keypad_row))
    }
    if(case1 && case2){
        return(or_paths(case1, case2))
    }
    if(case1){
        return(case1)
    }
    if(case2){
        return(case2)
    }
    return("A")
}

function repeated(letter, times,      r, i){
    r = ""
    for(i=1; i<= times; i++){
        r = r letter
    }
    return(r)
}
