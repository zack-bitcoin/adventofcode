BEGIN {
    #simulate_steps = 12
    #simulate_steps = 1024
}

{
    Line[NR] = $0
}


END {
    print("many lines " NR)
    for(i=1; i<=NR ;i++){
        split(Line[i], x, ",")
        X = x[1]+0
        Y = x[2]+0
        S = max(Y, max(X, S))
    }
    print(final_fun(1, NR))
}
function final_fun(ss1, ss2){
    if(ss1 == ss2-1){
        return(Line[ss2])
    }
    ss = int((ss1+ss2)/2)
    for(i in filled){
        delete filled[i]
    }
    for(i in Grid){
        delete Grid[i]
    }
    simulate_steps = ss
    for(i=1; i<=ss; i++){
        split(Line[i], x, ",")
        X = x[1]+0
        Y = x[2]+0
        Grid[X, Y] = "#"
    }
    touching[0, 0] = 1
    cpl = calc_path_lengths(touching, 0, S, S)
    if(cpl == "disconnected"){
        return(final_fun(ss1, ss))
    } else {
        return(final_fun(ss, ss2))
    }
}

function calc_path_lengths(touching, acc, final_x, final_y,     s, X, Y, touching2){
    #print("calc path lengths " acc)
    #draw_grid()
    s = ""
    empty = 1
    for(i in touching){
        empty = 0
        split(i, p, SUBSEP)
        X = p[1]
        Y = p[2]
        s = s ";" X " " Y
        filled[X+0, Y+0] = 1
        #print("try terminate: " X " " Y " " final_x " " final_y)
        if((X == final_x) && (Y == final_y)){
            return(acc)
        }
    }
    if(empty == 1){
        return("disconnected")
    }
    #print(s)
    for(i in touching){
        split(i, p, SUBSEP)
        X=p[1]
        Y=p[2]
        #print("for i in touching " i)
        accumulate_touching(touching2, X, Y+1)
        accumulate_touching(touching2, X, Y-1)
        accumulate_touching(touching2, X+1, Y)
        accumulate_touching(touching2, X-1, Y)
    }
    return(calc_path_lengths(touching2, acc+1, final_x, final_y))
}
function accumulate_touching(touching, X, Y){
    if((X < 0) || (X > S) || (Y < 0) || (Y > S)){
        #print("not accumulating B " X " " Y " " S)
        return(0)
    }
    if((X, Y) in Grid){
        #print("not accumulating G " X " " Y)
        return(0)
    }
    if((X, Y) in filled){
        #print("not accumulating " X " " Y)
        return(0)
    }
    #print("accumulate touching " X " " Y)
    touching[X, Y] = 1
    return(0)
}


function max(a, b){
    if(a > b){
        return(a)
    } else {
        return(b)
    }
}

function draw_grid(      i, j){
    for(i=0; i<=S; i++){
        s = ""
        for(j=0; j<=S; j++){
            if((j, i) in Grid){
                s = s Grid[j, i]
            } else if((j, i) in filled){
                s = s "O"
            } else {
                s = s "."
            }
        }
        print(s)
    }
}


#wrong 2933
