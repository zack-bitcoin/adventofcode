function unpack(s, arr,       a, m){
    m = split(s, a, ";")
    for(i=1; i<=m; i++){
        split(a[i], a2, " ")
        arr[a2[1]""] = a2[2]+0
    }
}

BEGIN {
    numeric_rows = "7 1;8 1;9 1;4 2;5 2;6 2;1 3;2 3;3 3;0 4;A 4"
    numeric_cols = "7 1;8 2;9 3;4 1;5 2;6 3;1 1;2 2;3 3;0 2;A 3"
    direction_rows = "^ 1;A 1;< 2;v 2;> 2"
    direction_cols = "^ 2;A 3;< 1;v 2;> 3"

    unpack(numeric_rows, numeric_row)
    unpack(numeric_cols, numeric_col)
    unpack(direction_rows, direction_row)
    unpack(direction_cols, direction_col)
}
{
    kp = keypad_process($0, 3,4)
    min_code = length_after_expanding(kp, 2)
    match($0, /[0-9]+/)
    numeric_part = substr($0, RSTART, RLENGTH)
    sum += (min_code * numeric_part)
    print("sum so far " sum " " min_code " " numeric_part)
}
END {
    print(sum)
}

function length_after_expanding(l, times,       m, a, r, len, i){
    #l is a list of sequences of button presses. We need to handle each sequence, and return the lowest of them all.
    m = split(l, a, ";")
    r = 100000000000000000
    for(i=1; i<=m; i++){
        len = length_after_expanding2(a[i], times)
        r = min(len, r)
    }
    return(r)
}
function min(a, b){
    if(a < b){ return(a)}
    return(b)
}
function length_after_expanding2(s, times,     m, a, r, code, i){
    #s is a sequence of button presses. we want to chop it up into individual button presses.
    m = split(s, a, "A")
    r = 0
    for(i=1; i<=m-1; i++){
        code = a[i] "A"
        r += expand_button_times(code, times)
    }
    return(r)
}
function expand_button_times(code, times,     code2, r){
    if(times == 0){
        return(length(code))
    }
    if((code, times) in LAE){
        return(LAE[code, times])
    }
    code2 = expand_button(code)
    r = length_after_expanding(code2, times-1)
    LAE[code, times] = r
    return(r)
}
function expand_button(kp,      m, kp2, i){
    m = split(kp, kpb, ";")
    kp2 = ""
    for(i=1; i<=m; i++){
        kp2 = kp2 ";" direction_process(kpb[i], 3, 1)
    }
    kp2 = substr(kp2, 2, length(kp2))
    return(kp2)
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
function paths_to(letter, keypad_col, keypad_row,     case1,case2, col, row){
    if((keypad_row == 4) && (keypad_col == 1)){
#disallowed, numeric_row = 4, numeric_col = 1
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
function direction_paths_to(letter, keypad_col, keypad_row,       case1, case2, times, letters){
    #print("direction paths to " letter, keypad_col, keypad_row)
    if((keypad_row == 1) && (keypad_col == 1)){
#disallowed, direction_row = 1, direction_col = 1
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

function repeated(letter, times,      r, i){
    r = ""
    for(i=1; i<= times; i++){
        r = r letter
    }
    return(r)
}

