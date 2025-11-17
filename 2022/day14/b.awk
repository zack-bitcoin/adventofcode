#49:32

BEGIN{
    for(x=450; x<=550; x++){
        for(y=0; y<=200; y++){
            filled[x][y] = 0
        }
    }
    maxy = 0
    minx = 10000000
    maxx = 0
}
function max(a, b){
    if(a>b){return (a)}
    return(b)
}
{
    Steps = split($0, A, " -> ")
    split(A[1], B, ",")
    prevx = B[1]
    prevy = B[2]
    for(i=2; i<=Steps; i++){
        split(A[i], B, ",")
        x = B[1]
        y = B[2]
        maxy = max(y, maxy)
        maxx = max(x, maxx)
        minx = min(x, minx)
        if(y == prevy){
            r = abs(x - prevx)
            for(j=0; j<=r; j++){
                filled[min(x, prevx)+j][y] = 1
            }
        } else if(x == prevx){
            r = abs(y - prevy)
            for(j=0; j<=r; j++){
                filled[x][min(y, prevy)+j] = 1
            }
        } else {
            print("impossible error 1")
            print(y, prevy, x, prevx)
        }
        prevx = x
        prevy = y
    }
}
function make_image(frame_number,      width, height, s, y, x, f, color){
    width = maxx - minx + 15
    height = FLOOR + 2
    if((height % 2) == 1){
        height += 1
    }
    if((width % 2) == 1){
        width += 1
    }
    #s = "P3\n"width " " height"\n255\n"
    s = "P2\n"width " " height"\n2\n"
    for(y=0; y<height; y++){
        for(x=0; x<width; x++){
            f = filled[x+minx-6][y-1]
            if(f == 1){#rock
                #color = "0 0 0"
                color = "0"
            } else if(f == 2){#sand
                #color = "128 128 128"
                color = "1"
            } else {#air
                #color = "255 255 255"
                color = "2"
            }
            s = s color "\n"
        }
    }
    filename = "frame" (1000 + frame_number)
    print(s) > (filename ".txt")
    system("convert "filename".txt "filename".jpg")
}

function add_sand(){
    simulate(500, 0)
}
function simulate(x, y){
    if(y >= FLOOR+1){
        filled[x][y] = 2
        return(1)
    }
    if(filled[x][y+1] == 0)
        return(simulate(x, y+1))
    if(filled[x-1][y+1] == 0)
        return(simulate(x-1, y+1))
    if(filled[x+1][y+1] == 0)
        return(simulate(x+1, y+1))
    if((x == 500) && (y == 0)){
        done = 1
        return(0)
    }
    filled[x][y] = 2
    return(1)
}
END {
    FLOOR = maxy
    steps = 50
    done = 0
    while(!done){
        add_sand()
        if((sands % steps) == 0){
            print("step " sands)
            make_image(int(sands / steps))
        }
        sands += 1
    }
    print(sands)
    system("convert -delay 10 -loop 0 frame*.jpg sand.mp4")
    system("rm frame*")
}
function min(a, b){
    if(a < b){return(a)}
    return(b)
}
function abs(a) {
    if(a < 0){return(-a)}
    return(a)
}
