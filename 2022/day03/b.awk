#15:26
BEGIN{
    letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ"
    cycle = 0
}
{
    if(cycle == 0){
        first = $0
        cycle += 1
    } else if(cycle == 1){
        second = $0
        cycle += 1
    } else if(cycle == 2){
        third = $0
        c = common_letter(first, second, third)
        total += priority(c)
        cycle = 0
    }
}

function is_in(letter, string){
    return(match(string, letter))
}

function common_letter(a, b, c){
    first = substr(a, 1, 1)
    bool = is_in(first, b)
    bool2 = is_in(first, c)
    if(bool && bool2) {
        return(first)
    }
    return(common_letter(substr(a, 2), b, c))
}

function priority(x){
    match(letters, x)
    return(RSTART)
}

END{
    print(total)
}
