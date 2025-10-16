#18:43

{
    s = $0
    match(s, /[0-9]+/)
    n1 = substr(s, RSTART, RLENGTH)+0
    rest = substr(s, RSTART+RLENGTH)
    match(rest, /[0-9]+/)
    n2 = substr(rest, RSTART, RLENGTH)+0
    rest = substr(rest, RSTART+RLENGTH)
    match(rest, /[0-9]+/)
    n3 = substr(rest, RSTART, RLENGTH)+0
    rest = substr(rest, RSTART+RLENGTH)
    match(rest, /[0-9]+/)
    n4 = substr(rest, RSTART, RLENGTH)+0
    if((n2 >= n3) && ( n1 <= n4)){
            total += 1
    }
}

END{
    print("total: " total)
}
