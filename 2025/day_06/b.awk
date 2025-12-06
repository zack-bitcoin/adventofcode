#rank 1583
#time 32:54

BEGIN{
    num_rows = 0
}

/[0-9]/ {
    num_rows += 1
    l = length($0)
    for(i=1; i<=l; i++){
        Digit[num_rows][i] = substr($0, i, 1)
    }
}

/[*]/ {
    l = length($0)
    ops = 0
    for(i=1; i<=l; i++){
        if(substr($0, i, 1) == " "){
        } else {
            ops += 1
            OpPos[ops] = i
        }
    }
    OpPos[ops+1] = i+1

    Width = split($0, A, /[ ]+/)
    pos = 1
    for(i=1; i<=Width; i++){
        if(A[i]){
            Ops[pos] = A[i]
            pos += 1
            #print(A[i])
            operation
        }
    }
}

END{
    for(i=1; i<=ops; i++){#for each operation
        s1 = Ops[i]
        for(j=OpPos[i]; j<=(OpPos[i+1] - 2); j++){
            #loop over the digits
            s = ""
            for(k=1; k<=num_rows; k++){
                #loop over the numbers
                s = s Digit[k][j]
            }
            s1 = s1 " " (s+0)
        }
        #print(s1 " -> " apply(s1))
        sum += apply(s1)
    }
    print("result: " sum)
}
function apply(s,     M, A, x, i) {
    M = split(s, A, " ")
    if(A[1] == "*"){
        x = 1
        for(i=2; i<=M; i++){
            x = x * A[i]
        }
        return(x)
    }
    if(A[1] == "+"){
        x = 0
        for(i=2; i<=M; i++){
            x = x + A[i]
        }
        return(x)
    }
}
