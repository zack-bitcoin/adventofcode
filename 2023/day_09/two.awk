function all_zeros(size, a,      r, i){
    r = 1
    for(i=1; i<=size; i++){
        if(!(a[i] == 0)){
            r = 0
        }
    }
    return(r)
}

function predict_prev(many, a,       b, c, i){
    if(all_zeros(many, a)){
        return(0)
    }
    for(i=1; i<= many-1; i++){
        b[i] = a[i+1] - a[i]
    }
    c = predict_prev(many-1, b)
    return(a[1] - c)
}


{
    m = split($0, a, " ")
    n = predict_prev(m, a)
    sum += n

}
END{
    print(sum)
}
