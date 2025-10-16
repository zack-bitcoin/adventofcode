#1:06:14

BEGIN{
RS = ""
i = 0
Operations[0] = ""
}

{
    split($0, S, "\n")
    Items[i] = ","substr(S[2], 18)
    Operations[i] = substr(S[3], 14)
    match(S[4], /[0-9]+/)
    Tests[i] = substr(S[4], RSTART, RLENGTH)
    match(S[5], /[0-9]+/)
    True[i] = substr(S[5], RSTART, RLENGTH)
    match(S[6], /[0-9]+/)
    False[i] = substr(S[6], RSTART, RLENGTH)

    i+=1
}

function throw(to, value){
    Items[to] = Items[to] "," value
}

function apply_test(test, value){
    return((int(value) % int(test)) == 0)
}

function apply_op(operation, value){
    if(match(operation, /\+/)){
        match(operation, /[0-9]+/)
        a = int(substr(operation, RSTART, RLENGTH))
        return(a + value)
    } else if(match(operation, /\*/)){
        if(match(operation, /[0-9]+/)){
            a = int(substr(operation, RSTART, RLENGTH))
            return(a * value)
        } else {
            return(value * value)
        }
    } else {
        print("impossible error")
    }
}

function round(       k, N, j, value, b, i) {
    for(k=0; k<ManyMonkeys; k++){
        N = split(Items[k], A, ",")
        for(j=2; j<=N; j++){
            #inspect, operation, bored, test, throw
            inspected[k] += 1
            value = int(A[j])
            value = apply_op(Operations[k], value)
            #value = int(value / 3)
            value = value % Factor
            b = apply_test(Tests[k], value)
            if(b){
                throw(True[k], value)
            } else {
                throw(False[k], value)
            }
        }
        Items[k] = ""
    }
}


END {
    ManyMonkeys = i
    Factor = 1
    for(i=0; i<ManyMonkeys; i++){
        Factor = Factor * int(Tests[i])
    }
    for(i=1; i<=10000; i++){
        round()
    }
    for(i=0; i<ManyMonkeys; i++){
        print("monkey " i ": " inspected[i])
    }
}

