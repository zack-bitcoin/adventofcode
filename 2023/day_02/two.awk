function maximum(a, b){
    if(a < b){
        return(b)
    } else {
        return(a)
    }
}
BEGIN{
    sum = 0
    digit_regex = "[0-9]+"
}
{
    min["red"] = 0
    min["blue"] = 0
    min["green"] = 0
    split($0, t, ":")
    l = split(t[2], u, ";")
    for(i=1;i<=l;i++){
        m = split(u[i], v, ",")
        for(j=1;j<=m;j++){
            w = v[j]
            match(w, digit_regex)
            many = substr(w, RSTART, RLENGTH)+0
            print("many: " many)
           match(w, /[a-z]+/)
           color = substr(w, RSTART, RLENGTH)
           min[color] = maximum(min[color], many)
        }
    }
    power = min["red"] * min["blue"] * min["green"]
    print("pwoer: " power)
    sum+=power
}

END{
    print(sum)
}
