#18:14

BEGIN{

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
    walk(direction, distance)
}


function walk(direction, distance){
    if(distance < 1){
        #print("position " Hx " " Hy)
        return(0)
    }
    if(direction == "R"){
        Hx += 1
    }
    if(direction == "L"){
        Hx -= 1
    }
    if(direction == "U"){
        Hy += 1
    }
    if(direction == "D"){
        Hy -= 1
    }
    tail_update()
    return(walk(direction, distance-1))
}
function abs(x) {
    if(x < 0){ return(-x)}
    return(x)
}
function tail_update(){
    xd = abs(Hx - Tx)
    yd = abs(Hy - Ty)
    #print("tail update " Hx " " Tx " " Hy " " Ty)
    if((xd > 1) ||
       (yd > 1)){
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
        #print("visited " Tx " " Ty)
        visited[Tx][Ty] = 1
    }
}

END {
    #print("end")
    for(i in visited){
        for(j in visited[i]){
            total += 1
        }
    }
    print("total is: " total)
}
