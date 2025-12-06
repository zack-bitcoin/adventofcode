#rank 2284
#time 12:18
BEGIN{
    num_rows = 0
}
/[*]/ {
    #store the operators in order
    Width = split($0, A, /[ ]+/)
    pos = 1
    for(i=1; i<=Width; i++){
        if(A[i]){
            Ops[pos] = A[i]
            pos += 1
        }
    }
}
/[0-9]/ {
    #store the numbers in order for each row.
    num_rows += 1
    Width = split($0, A, /[ ]+/)
    pos = 1
    for(i=1; i<=Width; i++){
        if(A[i]){
            Nums[num_rows][pos] = A[i]
            pos += 1
        }
    }
}
END{
    for(i=1; i<=Width; i++){
        s = Ops[i]
        for(j=1; j<=num_rows; j++){
            s = s " " Nums[j][i]
        }
        r = apply(s)
        sum += r
        print(s " -> " r)
    }
    print("result is: " sum)
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
