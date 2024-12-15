function finite_normalize(X, field){
    X = (((X % field) + field) % field)
    return(X)
}

function move_robots(Distance, Map2,         i, s, x, y, dx, dy, X, Y, Map){
    for(i=1; i<=NR; i++){
        s = Robot[i]
        split(s, a, " ")
        x = a[1]
        y = a[2]
        dx = a[3]
        dy = a[4]
        X = x + (dx * Distance)
        Y = y + (dy * Distance)
        X = finite_normalize(X, width)
        Y = finite_normalize(Y, height)
        Map[Y, X] += 1
    }
    for(key in Map2){
        delete Map2[key]
    }
    for(key in Map){
        Map2[key] = Map[key]
    }
}

function safety_factor(N,       Map, a, b, c, d, hw, hh){
        
    a = 0
    b = 0
    c = 0
    d = 0
        
    move_robots(N, Map)
    hw = int(width / 2)
    hh = int(height / 2)
    for(i = 0; i<hh; i++){
        for(j=0; j<hw; j++){
            if((i, j) in Map){
                a = a +  Map[i, j]
            }
            if((i+hh+1, j) in Map){
                b = b + Map[i+hh+1, j]+0
            }
            if((i, j+hw+1) in Map){
                c = c + Map[i, j+hw+1]+0
            }
            if((i+hh+1, j+hw+1) in Map){
                d = d + Map[i+hh+1, j+hw+1]+0
            }
        }
    }
    #print(a " " b " " c " " d)
    return(a * b * c * d)
}

function display(N,     Map, i, s, j){
    move_robots(N, Map)

    for(i=0; i<height; i++){
        s = ""
        for(j=0; j<width; j++){
            if((i, j) in Map){
                s = s Map[i, j]
            } else {
                s = s "."
            }
        }
        print(s)
    }
            
}


BEGIN {
    reg = "-?[0-9]+"
}

{
    s = $0
    match(s, reg)
    x = substr(s, RSTART, RLENGTH)
    sub(reg, "", s)
    match(s, reg)
    y = substr(s, RSTART, RLENGTH)
    sub(reg, "", s)
    match(s, reg)
    dx = substr(s, RSTART, RLENGTH)
    sub(reg, "", s)
    match(s, reg)
    dy = substr(s, RSTART, RLENGTH)
    sub(reg, "", s)
    Robot[NR] = x " " y " " dx " " dy
    #print(x "," y " " dx"," dy)
}

END{
#height =  7
#width = 11
height =  103
width = 101

print(safety_factor(100))
}

