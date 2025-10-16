BEGIN {
    letters = "abcdefghijklmnopqrstuvwxyzE"
}

/E/ {
    match($0, /E/)
    EndRow = NR
    EndCol = RSTART
}
/S/ {
    match($0, /S/)
    StartRow = NR
    StartCol = RSTART
}

{
    ManyCols = length($0)
    Lines[NR] = $0
    for(i=1; i<=length($0); i++){
        Grid[NR][i] = substr($0, i, 1)
    }
}


function letter2number(l){
    match(letters, l)
    return(RSTART)
}
END{
    #filled[StartRow][StartCol] = 1
    print("result: " shortest_path(StartRow, StartCol, 0, StartRow","StartCol))
}

function in_bounds(Row, Col) {
    if(Row < 1) {
        return(0)
    }
    if(Row > NR) {
        return(0)
    }
    if(Col < 1) {
        return(0)
    }
    if(Col > ManyCols) {
        return(0)
    }
    return(1)
}

function in_path(Row, Col, Path,     M, A, i){
    M = split(Path, A, ";")
    for(i=1; i<=M; i++){
        split(A[i], B, ",")
        if((Row == B[1]) && (Col == B[2])){
            return(1)
        }
    }
    return(0)
}

function can_walk(Row, Col, Path, Row2, Col2, steps){
    D = Distance[Row2][Col2]
    if((D > 0) && (steps+1 >= D)){
        return(0)
    }
    if(!(in_bounds(Row2, Col2))){
        return(0)
    }
    Elevation1 = letter2number(Grid[Row][Col])
    Elevation2 = letter2number(Grid[Row2][Col2])
    if(Elevation2 > (Elevation1+1)){
        return(0)
    }
    return(1)
}

function shortest_path(Row, Col, steps, Path,     a, b, c, d) {
    #print("shortest path, " steps " " Row " " Col)
    Distance[Row][Col] = steps
    if((Row == EndRow)&&(Col == EndCol)){
        return(steps)
    }
    a = 9999999
    if(can_walk(Row, Col, Path, Row+1, Col, steps)){
        a = shortest_path(Row+1, Col, steps+1, Path ";"Row+1","Col)
    }
    b = 9999999
    if(can_walk(Row, Col, Path, Row-1, Col, steps)){
        b = shortest_path(Row-1, Col, steps+1, Path ";"Row-1","Col)
    }
    c = 9999999
    if(can_walk(Row, Col, Path, Row, Col+1, steps)){
        c = shortest_path(Row, Col+1, steps+1, Path ";"Row","Col+1)
    }
    d = 9999999
    if(can_walk(Row, Col, Path, Row, Col-1, steps)){
        d = shortest_path(Row, Col-1, steps+1, Path ";"Row","Col-1)
    }
    return(min(min(a, b), min(c, d)))
}

function draw_filled(filled,       x, y, s){
    for(x = 1; x<= NR; x++){
        s = ""
        for(y = 1; y<=ManyCols; y++){
            if(filled[x][y]){
                s = s "#"
            } else {
                s = s "_"
            }
        }
        print(s)
    }
}


function expand(filled){
    print("expand " filled[EndRow][EndCol])
    copy(filled, filled2)
    for(x in filled2){
        if((x > 0) && ( x < NR)){
            for(j in filled2[x]){
                if(filled2[x][j] == 1){
                    if((j > 0) && ( j < ManyCols)){
                        #print("fill up " x " " j)
                        if(Grid[x][j+1] == "E"){
                            filled[x][j+1]
                        }
                        if(Grid[x][j-1] == "E"){
                            filled[x][j+1]
                        }
                        if(Grid[x+1][j] == "E"){
                            filled[x+1][j]
                        }
                        if(Grid[x-1][j] == "E"){
                            filled[x-1][j]
                        }
                        elevation = letter2number(Grid[x][j])
                        if(letter2number(Grid[x][j+1]) < (elevation + 2)) {
                            filled[x][j+1] = 1
                        }
                        print(x, j)
                        print(x, j, letter2number(Grid[1][0]))
                        if(letter2number(Grid[x][j-1]) < (elevation + 2)) {
                            filled[x][j-1] = 1
                        }
                        if(letter2number(Grid[x+1][j]) < (elevation + 2)) {
                            filled[x+1][j] = 1
                        }
                        if(letter2number(Grid[x-1][j]) < (elevation + 2)) {
                            filled[x-1][j] = 1
                        }
                    }
                }
            }
        }
    }
}
    

function shortest_path_old(Row, Col, filled,     filled1, filled2, filled3, filled4, a, b, c, d, result){
    #print("shortest path " Row " " Col " " Grid[Row][Col])
    if(Grid[Row][Col] == "E"){
        #print("found that E " filled[Row][Col] " " NR)
    }
    if(Row < 1) {
        return(99999999)
    }
    if(Col < 1) {
        return(99999999)
    }
    if(Row > NR){
        return(99999999)
    }
    if(Col > ManyCols){
        return(99999999)
    }
        
    if(filled[Row][Col] == 1){
        return(99999999)
    }
    filled[Row][Col] = 1
    if(Grid[Row][Col] == "E"){
        print("found that E")
        total = 0
        for(x in filled){
            total+=1
        }
        print("total is " total)
        return(total)
    }
    copy(filled, filled1)
    copy(filled, filled2)
    copy(filled, filled3)
    copy(filled, filled4)
    a = shortest_path(Row+1, Col, filled1)
    b = shortest_path(Row, Col+1, filled2)
    c = shortest_path(Row-1, Col, filled3)
    d = shortest_path(Row-1, Col, filled4)
    result = min(min(a, b), min(c, d))
    #print(a, b, c, d, result)
    return(result)
}

function min(a, b){
    if(a < b) {return a}
    else {return b}
}

function copy(M, R,     K, N, j){
    for(K in M){
        for(j in M[K]){
            R[K][j] = M[K][j]
        }
    }
}
