#rank 1113
#time 17:39
BEGIN{
    sum = 0
    line = 1
}
{
    print(line)
    line+=1
    sum += max_joltage($0, 12)
}
END{
    print(sum)
}
function max_joltage(s, digits,       l, f, f2, s2){
    if(digits == 0){return("")}
    l = length(s)
    f = substr(s, 1, l-digits+1)#remove the suffix not being used to find the next digit.
    f2 = highest_digit(f)
    s2 = f2 substr(s, l-digits+2)
    return(substr(f2, 1, 1) max_joltage(substr(s2, 2), digits-1))
}
function highest_digit(s,       max_val, l, i){
    #finds the biggest digit in the list. earlier digits win ties.
    #returns the part of the list we are still considering for further digits. The first digit of this list is the next digit of the output.
    max_val = 0
    l = length(s)
    for(i=1; i<=l; i++){
        max_val0 = max_val
        max_val = max(max_val, substr(s, i, 1)+0)
        if(max_val > max_val0){
            result = substr(s, i)
        }
    }
    return(result)
}
function max(a, b){
    if(a > b){return(a)}
    return(b)
}
