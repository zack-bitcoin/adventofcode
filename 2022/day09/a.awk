#18:14

BEGIN{
    frame_number = 1
    Hx = 1
    Hy = 1
    Tx = 1
    Ty = 1
    visited[1][1] = 1
}

{
    direction = substr($0, 1, 1)
    distance = substr($0, 3)
    #print("walk " distance " in direction " direction)
    #draw_frame(frame_number)
    print("line: " NR)
    walk(direction, distance)
    frame_number += 1
    draw_frame(frame_number)
}

function draw_frame(number,      x, y, width, height, s, color, filename){
    #print("draw frame " number, "at: " Hx, Hy, "and: " Tx, Ty)
    width = 13+181
    height = 353+25

    s = "# ImageMagick pixel enumeration: "width","height",255,srgb\n"
    for(y = 24; y >= -353; y--){
        for(x = -181; x <= 12; x++){
            if((x == 0) && (y == 0)){#start
                color = ": (255,255,0)  #FFFF00  srgb(255,255,0)"
            } else if((Hx == x) && (Hy == y)){#head
                color = ": (0,0,0)  #000000  srgb(0,00,0)"
            } else if((Tx == x) && (Ty == y)){#tail
                color = ": (0,255,0)  #00FF00  srgb(0,255,0)"
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

function walk(direction, distance){
    if(distance < 1){return(0)
    }else if(direction == "R"){ Hx += 1
    }else if(direction == "L"){ Hx -= 1
    }else if(direction == "U"){ Hy += 1
    }else if(direction == "D"){ Hy -= 1}
    tail_update(Hx, Hy)
    return(walk(direction, distance-1))
}
function abs(x) {
    if(x < 0){ return(-x)}
    return(x)
}
function tail_update(          xd, yd){
    xd = abs(Hx - Tx)
    yd = abs(Hy - Ty)
    #print("tail update " Hx " " Tx " " Hy " " Ty)
    if((xd > 1) || (yd > 1)){
        #take a step
        if(xd == 0){
            Ty = int((Hy + Ty)/2)
        } else if(yd == 0){
            Tx = int((Hx + Tx)/2)
        } else if(xd == 1){
            Tx = Hx
            Ty = int((Hy + Ty)/2)
        } else if(yd == 1){
            Ty = Hy
            Tx = int((Hx + Tx)/2)
        } else {
            print("impossible tail update case")
        }
        visited[Tx][Ty] = 1
    }
}

END {
    for(i in visited){
        for(j in visited[i]){
            total += visited[i][j]
        }
    }
    print("total is: " total)
    system("convert -delay 1 -loop 0 frame*.jpg whip.mp4")
}
