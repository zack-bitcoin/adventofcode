function read_db(row, col) {
    if((row < 0) || (row > NR) || (col < 0) || (col > cols)){
        return("#")
    }
    return(DB[row, col])
}

function roll(row, col, rd, cd) {
    path = read_db(row+rd, col+cd)
    if(path == "."){
        DB[row, col] = "."
        DB[row+rd, col+cd] = "O"
        return(roll(row+rd, col+cd, rd, cd))
    }
    if(path == "."){
        return(0)
    }
}

function tilt(rd, cd,       row, col, x){
    for(row = 1; row<=NR; row++){
        for(col = 1; col<=cols; col++){
            x = DB[row, col]
            if(x == "O"){
                roll(row, col, rd, cd)
            }
        }
    }
}
function load(       x, n){
    x = 0
    for(row = 1; row<=NR; row++){
        for(col = 1; col<=cols; col++){
            if(DB[row, col] == "O"){
                n = NR - row + 1
                x = x + n
            }
        }
    }
    return(x)
}


{
    cols = length($0)
    for(i=1; i<=cols; i++){
        DB[NR, i] = substr($0, i, 1)
    }
}

END{
    tilt(-1, 0)
    for(row = 1; row<=NR; row++){
        s = ""
        for(col = 1; col<=cols; col++){
            s = s DB[row, col]
        }
        #print(s)
    }
    print(load())
}
