function gcd(p,q){return(q?gcd(q,(p%q)):p)}


BEGIN{
    a = 11567
    b = 14257
    c = 19099
    d = 16409
    e = 12643
    f = 21251

    g = gcd(a, b)
    acc = a * b / g
    g = gcd(acc, c)
    acc = acc * c / g
    g = gcd(acc, d)
    acc = acc * d / g
    g = gcd(acc, e)
    acc = acc * e / g
    g = gcd(acc, f)
    acc = acc * f / g

    print(acc)

}
