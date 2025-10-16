# 12:14

BEGIN {
    strengths = "20 60 100 140 180 220"
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
        total += increase_by
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
    print(total)
}
