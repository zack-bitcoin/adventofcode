BEGIN{
    for(i=1; i<=10; i++){
        Xs[i] = 1
        Ys[i] = 1
    }
    visited[1][1] = 1
    frame_number = 1
    draw_frame(frame_number)
}
{
    direction = substr($0, 1, 1)
    distance = substr($0, 3)
    print("step " NR)
    walk(direction, distance)
    frame_number += 1
    draw_frame(frame_number)
}
function draw_frame(number,      x, y, width, height, s, color, filename){
    width = 13+181
    height = 353+25
    s = "# ImageMagick pixel enumeration: "width","height",255,srgb\n"
    for(y = 24; y >= -353; y--){
        for(x = -181; x <= 12; x++){
            tail_bool = in_tail(x, y)
            if((x == 0) && (y == 0)){#start
                color = ": (255,255,0)  #FFFF00  srgb(255,255,0)"
            } else if(tail_bool){
                color = ": (0,0,0)  #000000  srgb(0,0,0)"
            } else if(visited[x][y]){
                color = ": (255,0,0)  #FF0000  srgb(255,0,0)"
            } else {
                color = ": (255,255,255)  #FFFFFF  srgb(255,255,255)"
            }
            s = s (x+181)","(24-y) color "\n"
        }
    }
    filename = "frame" (1000 + number)
    print(s) > (filename ".txt")
    system("convert "filename".txt "filename".jpg")
    system("rm "filename".txt")
}
function in_tail(x, y,       i){
    for(i=1; i<=10; i++)
        if((x == Xs[i])&&(y == Ys[i]))
            return(1)
    return(0)
}
function walk(direction, distance){
    #print("walk " direction, distance)
    if(distance < 1){return(0)}
    if(direction == "R"){Xs[1] += 1}
    if(direction == "L"){Xs[1] -= 1}
    if(direction == "U"){Ys[1] += 1}
    if(direction == "D"){Ys[1] -= 1}
    tail_update()
    return(walk(direction, distance-1))
}
function abs(x) {
    if(x < 0){ return(-x)}
    return(x)
}
function print_tail(){
    s = ""
    for(i=1; i<=10; i++){
        s = s Xs[i] " " Ys[i] ";"
    }
    print(s)
}
function tail_update(       xd, yd){
    for(i=1; i<=9; i++){
        xd = abs(Xs[0+i] - Xs[1+i])
        yd = abs(Ys[0+i] - Ys[1+i])
        if((xd > 1) || (yd > 1)){
            if(xd == 2){Xs[1+i] = int((Xs[0+i] + Xs[1+i])/2)}
            if(yd == 2){Ys[1+i] = int((Ys[0+i] + Ys[1+i])/2)}
            if(xd == 1){Xs[1+i] = Xs[0+i]}
            if(yd == 1){Ys[1+i] = Ys[0+i]}
        }
        visited[Xs[10]][Ys[10]] = 1
    }
}
END {
    total = 0
    for(i in visited){
        for(j in visited[i]){
            total += visited[i][j]
        }
    }
    print("total is: " total)
    system("convert -delay 1 -loop 0 frame*.jpg whip2.mp4")
    system("rm frame*.jpg")
}
