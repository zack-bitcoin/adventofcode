function letter2number(l){
    match(letters, l)
    return(RSTART)
}
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
    system("convert -delay 2 -loop 0 frame*.jpg hill.mp4")
    system("rm frame*")
    print(result)
}
function min(a, b){
    if(!a){return(b)}
    if(!b){return(a)}
    if(a<b) {return(a)}
    return(b)
}
function in_bounds(Row, Col) {
    if(Row < 1) {return(0)}
    if(Row > NR) {return(0)}
    if(Col < 1) {return(0)}
    if(Col > ManyCols) {return(0)}
    return(1)
}
function can_walk(Row, Col, Row2, Col2, steps){
    D = Distance[Row][Col]
    if((D > 0) && (steps+1 >= D)){return(0)}
    if(!(in_bounds(Row, Col))){return(0)}
    Elevation1 = letter2number(Grid[Row][Col])
    Elevation2 = letter2number(Grid[Row2][Col2])
    if(Elevation2 > (Elevation1+1)){return(0)}
    return(1)
}
function border_grow(x2, y2, x, y, distance, Boarder2){
    if(can_walk(x2, y2, x, y, distance))
        Border2 = add_to_border(Border2, x2, y2)
}
function flood_distances(Border, distance){
    if(Border == ""){return(0)}
    Border2 = ""
    M = split(Border, A, ";")
    draw_frame(distance, Border)
    for(i = 0; i<=M; i++){
        split(A[i], B, ",")
        x = B[1]
        y = B[2]
        Distance[x][y] = distance
        border_grow(x-1, y, x, y, distance, Border2)
        border_grow(x+1, y, x, y, distance, Border2)
        border_grow(x, y-1, x, y, distance, Border2)
        border_grow(x, y+1, x, y, distance, Border2)
    }
    return(flood_distances(Border2, distance+1))
}
function in_border(Row, Col, Border,     M, A, i){
    M = split(Border, A, ";")
    for(i=1; i<=M; i++){
        split(A[i], B, ",")
        if((Row == B[1]) && (Col == B[2])){
            return(1)
        }
    }
    return(0)
}
function add_to_border(Border, x, y){
    if(in_border(x, y, Border)){
        return(Border)#no repeats.
    } else {
        return(Border ";" x "," y)
    }
}
function draw_frame(number, Border,      s, y, x, elevation, is_in, distance, color, n) {
    print("draw frame " number)
    width = NR
    if((width %2) == 1){width += 1}
    height = ManyCols
    if((height %2) == 1){height += 1}
    s = "# ImageMagick pixel enumeration: "width","height",255,srgb\n"
    for(y=1; y<=ManyCols; y++){
        for(x=1; x<=NR; x++){
            elevation = letter2number(Grid[x][y])
            is_in = in_border(x, y, Border)
            distance = Distance[x][y]
            if(is_in){#if in the border, make it green
                color = ": (0,255,0)  #00FF00  srgb(0,255,0)"
            } else if(distance){#if there is a distance, make it blue, lighter is nearer.
                n = int(255 * ((distance+50) / (375+50)))
                color = sprintf(": ("n","n",255)  #%.2X%.2XFF  srgb("n","n",255)", n, n)
            } else {#else, color by elevation, make it red. lighter is higher. lowest elevation is black.
                if(elevation == 1){
                    color = ": (0,0,0)  #000000  srgb(0,0,0)"
                } else {
                    n = int(255 * ((elevation+3) / (length(letters)+4)))
                    color = sprintf(": (255,"n","n")  #FF%.2X%.2X  srgb(255,"n","n")", n, n)
                }
            }
            s = s (x-1)","(y-1) color "\n"
        }
    }
    filename = "frame" (1000 + number)
    print(s) > (filename ".txt")
    system("convert "filename".txt "filename".jpg")
}
