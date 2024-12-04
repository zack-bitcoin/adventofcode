
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
function check_word(row, col,      a,b,c,d){
    if(!(get_letter(row, col) == "A")){
        return(0)
    }
    a = get_letter(row-1, col-1)
    b = get_letter(row-1, col+1)
    c = get_letter(row+1, col+1)
    d = get_letter(row+1, col-1)
    if(((a == "M") && (c == "S")) ||
       ((a == "S") && (c == "M"))){
        if(((b == "M") && (d == "S")) ||
           ((b == "S") && (d == "M"))){
            sum+=1
        }
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
            check_word(row, col)
        }
    }
    print(sum)
}
#wrong 2567
