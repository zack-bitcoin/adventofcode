BEGIN {
    letters = "abcdefghijklmnopqrstuvwxyzE"
}
/E/ {
    match($0, /E/)
    EndRow = NR
    EndCol = RSTART
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
    result = 99999999
    Distance[EndRow][EndCol] = 0
    flood_distances(EndRow","EndCol, 0)
    for(x=1; x<=NR; x++){
        for(y=1; y<=ManyCols; y++){
            if((Grid[x][y] == "a") || (Grid[x][y] == "S")){
                result = min(result, Distance[x][y])
            }
        }
    }
    print(result)
}
function min(a, b){
    if(!a){return(b)}
    if(!b){return(a)}
    if(a<b) {return(a)}
    return(b)
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

function can_walk(Row, Col, Row2, Col2, steps){
    D = Distance[Row][Col]
    #print("can walk " D " " steps)
    if((D > 0) && (steps+1 >= D)){
        return(0)
    }
    if(!(in_bounds(Row, Col))){
        return(0)
    }
    Elevation1 = letter2number(Grid[Row][Col])
    Elevation2 = letter2number(Grid[Row2][Col2])
    if(Elevation2 > (Elevation1+1)){
        return(0)
    }
    return(1)
}

function flood_distances(Border, distance){
    if(Border == ""){return(0)}
    Border2 = ""
    M = split(Border, A, ";")
    for(i = 0; i<=M; i++){
        split(A[i], B, ",")
        x = B[1]
        y = B[2]
        Distance[x][y] = distance
        if(can_walk(x-1, y, x, y, distance)){
            Border2 = add_to_border(Border2, x-1, y)
            #Border2 = Border2 ";" x-1 "," y
        }
        if(can_walk(x+1, y, x, y, distance)){
            Border2 = add_to_border(Border2, x+1, y)
        }
        if(can_walk(x, y-1, x, y, distance)){
            #Border2 = Border2 ";" x+1 "," y
            Border2 = add_to_border(Border2, x, y-1)
        }
        if(can_walk(x, y+1, x, y, distance)){
            #Border2 = Border2 ";" x+1 "," y
            Border2 = add_to_border(Border2, x, y+1)
        }
    }
    return(flood_distances(Border2, distance+1))
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
function add_to_border(Border, x, y){
    if(in_path(x, y, Border)){
        return(Border)
    } else {
        return(Border ";" x "," y)
    }
}
        
