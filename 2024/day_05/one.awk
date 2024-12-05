function middle_number(s,      m, a) {
    m = split(s, a, ",")
    return(a[int(m/2)+1])
}
function obeys_rules(s,     m, a) {
    m = split(s, a, ",")
    for(i=1; i<= m; i++){
        for(j=i+1; j<= m; j++){
            rule_check = a[i] "\\|" a[j]
            if(!(match(RulesString, rule_check))){ 
                return(0)
            }
        }
    }
    return(1)
}


/\|/ {
    RulesString = RulesString ":" $0
}

/,/ {
    if(obeys_rules($0)){
        #print("obeys: " $0)
        sum += middle_number($0)
    } else {
        #print("fails: " $0)
    }
}


END {
    print(sum)
}
