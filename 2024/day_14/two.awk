#I noticed that the robots seemed to organize horizontally every 101st round, and vertically every 103rd round. So, I calculated out how many rounds until they were aligned vertically and horizontally at the same time, manually testing many rounds to narrow in on the goal.



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
        #print("rewrite " key " in map2 to " Map[key])
        Map2[key] = Map[key]
    }
}

function safety_factor(N,       Map, a, b, c, d){
        
    a = 0
    b = 0
    c = 0
    d = 0
        
    move_robots(N, Map)
    #for(key in Map){
    #    print("safety input key" key)
    #}
    hw = int(width / 2)
    hh = int(height / 2)
    #print("safety start " width " " height " "hw " " hh)
    for(i = 0; i<hh; i++){
        for(j=0; j<hw; j++){
            #print("safety nums " i " " j)
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

function display(N,     Map, x, y, dx, dy, s, X, Y, i, j){
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

i = 8053
while(i <= 8053){
    print(i)
    display(i)
    print("")
    system("sleep 0.5")
    i+= 1
}
print("done")
#print(safety_factor(100))
}

#20
#74
#122
#175
#225
#276
#328
#377
#431
#478

# 54, 48, 53, 50, 51, 52, 49

#102, 103, 103, 103

#101, 101, 101

#122 + N*103 = 74 + M*101

#48 = M*101 - N*103

# M = 79, N=77
#20
#74
#122
#175
#225
#276
#328
#377
#431
#478

# 54, 48, 53, 50, 51, 52, 49

#102, 103, 103, 103

#101, 101, 101

#122 + N*103 = 74 + M*101

#48 = M*101 - N*103

# M = 79, N=77
