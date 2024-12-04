function get_letter(row, col){
    if(row< 1){
        return(".")
    }
    if(row > NR){
        return(".")
    }
    if(col< 1){
        return(".")
    }
    if(col > cols){
        return(".")
    }
return(substr(DB[row], col, 1))
}

function check_word(row, col, row_direction, col_direction, word,
                    db_val, next_letter){
    if(length(word)<1){
        #completely matched
        sum += 1
        return(1)
    }
    #db_val = substr(DB[row], col, 1)
    db_val = get_letter(row, col)
    next_letter = substr(word, 1, 1)
    if(db_val == next_letter){
        return(check_word(row + row_direction, col + col_direction,
                          row_direction, col_direction,
                          substr(word, 2, length(word) - 1)))
    }else{
        return(0)
    }
}

{
    DB[NR] = $0
    cols = length($0)
}

END{
    print(NR " " cols)
    for(row=1; row<=NR; row++){
        for(col=1; col<=cols; col++){
            check_word(row, col, 1, 0, "XMAS")
            check_word(row, col, 1, 1, "XMAS")
            check_word(row, col, 0, 1, "XMAS")
            check_word(row, col, -1, 1, "XMAS")
            check_word(row, col, -1, 0, "XMAS")
            check_word(row, col, -1, -1, "XMAS")
            check_word(row, col, 0, -1, "XMAS")
            check_word(row, col, 1, -1, "XMAS")
        }
    }
    print(sum)
}
