BEGIN {
    #simulate_steps = 12
    simulate_steps = 1024
}

{
    if(simulate_steps > 0){
        split($0, x, ",")
        X = x[1]+0
        Y = x[2]+0
        S = max(Y, max(X, S))
        #print("add " X " " Y)
        Grid[X, Y] = "#"
        simulate_steps -= 1
    }
    
}

END {
    S = S+1
    #draw_grid()
    touching[0, 0] = 1
    print(calc_path_lengths(touching, 0, S-1, S-1))
}

function calc_path_lengths(touching, acc, final_x, final_y,     s, X, Y, touching2){
    #draw_grid()
    s = ""
    for(i in touching){
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
    if((X < 0) || (X >= S) || (Y < 0) || (Y >= S)){
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
    for(i=0; i<S; i++){
        s = ""
        for(j=0; j<S; j++){
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


#132 too low
