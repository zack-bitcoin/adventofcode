#19:45

BEGIN {
    X = 1
    cycle = 0
    total = 0
}

function cycle_in_strengths(N, strengths){
    print("cycle is " N " x is " X)
    M = split(strengths, A, " ")
    for(i=1; i<=M; i++){
        if(int(A[i]) == N) {
            print("in strengths")
            return(1)
        }
    }
    return(0)
}

function cycle_bump(){
    cycle += 1
    B = cycle_in_strengths(cycle, strengths)
    if(B){
        increase_by = X * cycle
        print("increase by " increase_by)
    }
    pos = cycle % 40
    if((X > (pos-3)) && (X < (pos + 1))){
        s = s "#"
    } else {
        s = s "."
    }
}

/noop/ {
    cycle_bump()
}


/addx/ {
    cycle_bump()
    cycle_bump()
    print("addx increase by " $2)
    X += $2
}

END{
    #print(s)
    s1 = substr(s, 1, 40)
    s2 = substr(s, 41, 40)
    s3 = substr(s, 81, 40)
    s4 = substr(s, 121, 40)
    s5 = substr(s, 161, 40)
    s6 = substr(s, 201, 40)
    
    print(s1)
    print(s2)
    print(s3)
    print(s4)
    print(s5)
    print(s6)
}
