function possible2(total, vals, many){
    acc = vals[1]
    return(possible22(acc, total, vals, many, 2))
}
function possible22(acc, total, vals, many, n){
    if(n>many){
        return(acc == total)
    }
    return(possible22(acc + vals[n], total, vals, many, n+1) ||
           possible22(acc * vals[n], total, vals, many, n+1))
}
{
        split($0, a, ":")
        total = a[1]
        vals = a[2]
        many = split(vals, b)
        if(possible2(total, b, many)){
            sum+=total
        }
}
END{
    print(sum)
}

