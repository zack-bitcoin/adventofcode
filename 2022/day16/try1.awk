BEGIN{
    time = 30
    
}

{
    Names[NR] = substr($0, 7, 2)
    name = Names[NR]
    match($5, /[0-9]+/)
    Rate[name] = substr($5, RSTART, RLENGTH)
    if(Rate[name] == 0){
        zero_rated = ","name
    }
    split($0, A, "valves ")
    Paths[name] = A[2]
}

END{

    print(search("AA", time, substr(zero_rated, 2), 0, 0))
}

function search(name, time, opened, flow, accumulator,      rate, paths, result, M, A, i, X){
    print("search " name, time)
    if(accumulator < memoized_score[name, time, opened]){
        print("memoized skip")
        return(0)
    }
    memoized_score[name, time, opened] = accumulator
    M = split(opened, X, ",")
    if(M == NR){
        return(accumulator + (flow*time))
    }
    if(time < 1){
        print("finished search " accumulator " " opened)
        return (accumulator)
    }
    if(accumulator < (high_score[time+1])){
        print("score of " accumulator " in round " time " is too slow " opened)
        return(0)
    }
    high_score[time] = max(high_score[time], accumulator)
    rate = Rate[name]
    paths = Paths[name]
    result = 0
    if(!(alread_opened(name, opened))){
        result = search(name, time-1, opened","name,flow+rate, accumulator+flow)
    }
    M = split(paths, A, ", ")
    for(i=1; i<=M; i++){
        if(!(alread_opened(A[i], opened))){
            result = max(result, search(A[i], time-1, opened, flow, accumulator+flow))
        }
    }
    if(rand() > 0.5){
        for(i=1; i<=M; i++){
            if(alread_opened(A[i], opened)){
                result = max(result, search(A[i], time-1, opened, flow, accumulator+flow))
            }
        }
    } else {
        for(i=M; i>=1; i--){
            if(alread_opened(A[i], opened)){
                result = max(result, search(A[i], time-1, opened, flow, accumulator+flow))
            }
        }

    }
    return(result)
}
function max(a, b){
    if(!(a)) {return(b)}
    if(!(b)) {return(a)}
    if((a+0)< (b+0)){ return(b)}
    else {return (a)}
}
function alread_opened(name, opened,     M, A, i){
    M = split(opened, A, ",")
    for(i=1; i<=M; i++){
        if(A[i] == name){
            return(1)
        }
    }
    return(0)
}
