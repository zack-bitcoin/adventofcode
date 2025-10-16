
{
    Steps = split($0, A, " -> ")
    split(A[1], B, ",")
    prevx = B[1]
    prevy = B[2]
    for(i=2; i<=Steps; i++){
        split(A[i], B, ",")
        x = B[1]
        y = B[2]
        if(y == prevy){
            r = abs(x - prevx)
            for(j=0; j<r; j++){
                filled[min(x, prevx)+j][y] = 1
            }
        } else if(x == prevy){
            r = abs(y - prevy)
            for(j=0; j<r; j++){
                filled[x][min(y, prevy)+j] = 1
            }
        }
    }
}

END {
    for(x=496; x<=503; x++){
        s = ""
        for(y=3; y<=10; y++){
            if(filled[x][y]){
                s = s "#"
            } else {
                s = s " "
            }
        }
        print(s)
    }
        
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
