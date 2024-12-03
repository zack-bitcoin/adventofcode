function remove_all_dont_dos(s,        a, ma, i, j, ba, acc, b){
    ma = split(s, a, "don't\\(\\)")
    for(i=2; i<=ma; i++){
        ba = split(a[i], b, "do\\(\\)")
        for(j=2; j<=ba; j++){
            acc = acc b[j]
        }
    }
    return(a[1] acc)
}
BEGIN{
RS = "abcdjlfsdjfiosjfiowefoisjifjsdjfoisdjfiosd"
m = "mul\\([0-9][0-9]?[0-9]?,[0-9][0-9]?[0-9]?\\)"
}
{
    $0 = remove_all_dont_dos($0)
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

