BEGIN{
RS = "abcdjlfsdjfiosjfiowefoisjifjsdjfoisdjfiosd"
m = "mul\\([0-9][0-9]?[0-9]?,[0-9][0-9]?[0-9]?\\)"
}

{
    while(match($0, m)){
        x = substr($0, RSTART, RLENGTH)
        split(x, y, ",")
        match(y[1], /[0-9]+/)
        a = substr(y[1], RSTART, RLENGTH)
        match(y[2], /[0-9]+/)
        b = substr(y[2], RSTART, RLENGTH)
        sum += (a*b)
        sub(m, "", $0)
    }
}
END{
    print(sum)
}

#wrong 127212073
