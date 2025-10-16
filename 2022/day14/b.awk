#49:32

BEGIN{
    for(x=450; x<=550; x++){
        for(y=0; y<=200; y++){
            filled[x][y] = 0
        }
    }
    maxy = 0
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
        if(y == prevy){
            r = abs(x - prevx)
            for(j=0; j<=r; j++){
                #print("horizontal " y, min(x, prevx)+j)
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

function display(){
    for(y=-1; y<=10; y++){
        s = ""
        for(x=490; x<=510; x++){
            if(filled[x][y] == 1){
                s = s "#"
            } else if(filled[x][y] == 2) {
                s = s "o"
            } else {
                s = s "."
            }
        }
        print(s)
    }
}

function add_sand(){
    simulate(500, 0)
}
function simulate(x, y){
    #print("simulate " x " " y " " filled[x][y+1])
    if(y >= FLOOR+1){
        filled[x][y] = 2
        return(1)
        #done = 1
        #return(0)
    }
    if(filled[x][y+1] == 0){
        return(simulate(x, y+1))
    }
    if(filled[x-1][y+1] == 0){
        return(simulate(x-1, y+1))
    }
    if(filled[x+1][y+1] == 0){
        return(simulate(x+1, y+1))
    }
    if((x == 500) && (y == 0)){
        done = 1
        return(0)
    }
    #print("fill " x " " y " " filled[x][y])
    filled[x][y] = 2
    return(1)
}

END {
    FLOOR = maxy
    #print("")
    done = 0
    while(!done){
        #print("loop")
        add_sand()
        sands += 1
    }
    print(sands)
    #start pouring in sand at 0,500
}

function min(a, b){
    if(a < b){return(a)}
    return(b)
}
function abs(a) {
    if(a < 0){return(-a)}
    return(a)
}
