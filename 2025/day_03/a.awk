#rank 818
#time 6:58
BEGIN{
    sum = 0
    line = 1
}
{
    print(line)
    line+=1
    sum += max_joltage($0)
}
END{
    print(sum)
}

function max_joltage(s,        i, j, joltage, max_j){
    l = length(s)
    max_j = 0
    for(i=1; i<=l; i++){
        for(j=i+1; j<=l; j++){
            joltage = substr(s, i, 1) substr(s, j, 1)
            #print(max_j, joltage, i, j)
            joltage = joltage+0
            max_j = max(max_j, joltage)
        }
    }
    return(max_j)
}
function max(a, b){
    if(a > b){ return(a)}
    return(b)
}
