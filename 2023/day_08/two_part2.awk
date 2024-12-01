function gcd(p,q){
    if(q){
        return(gcd(q, p%q))
    }
    return(p)
}

function gmul(a, b){
    g = gcd(a, b)
    acc = a * b / g
    return(a)
}
function gmul_fold(a, start, end, acc2){
    if(start> end){return(acc2)}
    b = a[start]
    return(gmul_fold(a, start+1, end, acc2 * b / gcd(acc2, b)))
}

BEGIN{
    a[1] = 11567
    a[2] = 14257
    a[3] = 19099
    a[4] = 16409
    a[5] = 12643
    a[6] = 21251
    print(gmul_fold(a, 1, 6, 1))

}
