BEGIN{
    sum = 0
    limit["red"] = 12
    limit["green"] = 13
    limit["blue"] = 14
            digit_regex = "[0-9]+"
}


{
    valid_hand = 1
    match($0, digit_regex)
    game = substr($0, RSTART, RLENGTH)
    split($0, t, ":")
    l = split(t[2], u, ";")
    for(i=1;i<=l;i++){
        m = split(u[i], v, ",")
        for(j=1;j<=m;j++){
            w = v[j]
            match(w, digit_regex)
            many = substr(w, RSTART, RLENGTH)+0
           match(w, /[a-z]+/)
           color = substr(w, RSTART, RLENGTH)
           if(many > limit[color]){
              valid_hand=0
           }
        }

    }

    if(valid_hand==1){
        sum+=game
    }

}

END{
    print(sum)
}
