# this doesn't come up with the right solution. i gave up after 40 minutes.

BEGIN{
    for(i=1; i<=10; i++){
        Xs[i] = 1
        Ys[i] = 1
    }

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
        Xs[1] += 1
    }
    if(direction == "L"){
        Xs[1] -= 1
    }
    if(direction == "U"){
        Ys[1] += 1
    }
    if(direction == "D"){
        Ys[1] -= 1
    }
    tail_update()
    return(walk(direction, distance-1))
}
function abs(x) {
    if(x < 0){ return(-x)}
    return(x)
}
function tail_update(){
    for(i=1; i<=9; i++){
    xd = abs(Xs[0+i] - Xs[1+i])
    yd = abs(Ys[0+i] - Ys[1+i])
    #print("tail update " Hx " " Tx " " Hy " " Ty)
    if((xd > 1) ||
       (yd > 1)){
        #print("xd yd " xd " " yd)
        #take a step
        if(xd == 0){
            #print("straight step")
            Ys[1+i] = int((Ys[0+i] + Ys[1+i])/2)
        } else if(yd == 0){
            #print("straight step2")
            Xs[1+i] = int((Xs[0+i] + Xs[1+i])/2)
        } else if(xd == 1){
            #print("diag step")
            Xs[1+i] = Xs[0+i]
            Ys[1+i] = int((Ys[0+i] + Ys[1+i])/2)
        } else if(yd == 1){
            #print("diag step2")
            Ys[1+i] = Ys[0+i]
            Xs[1+i] = int((Xs[0+i] + Xs[1+i])/2)
        } else {
            #print("impossible tail update case")
        }
    }
    #print("visited " Xs[10] " " Ys[10])
    visited[Xs[10]][Ys[10]] = 1
    }
}

END {
    #print("end")
    for(i in visited){
        for(j in visited[i]){
            #print("visited " i " " j)
            total += 1
        }
    }
    print("total is: " total)
}
