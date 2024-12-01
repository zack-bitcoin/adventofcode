function read_num(s){
    match(s, /[0-9]/)
    a = substr(s, RSTART, RLENGTH)
    while(match(s, /[0-9]/)){
    last_digit = substr(s, RSTART, RLENGTH)
        sub(/[0-9]/, "", s)
    }
    return((a*10) + last_digit)
}


BEGIN {
    total = 0
}

{
    x = read_num($1)
    print(x)
    total += x
}

END{
    print(total)
}
