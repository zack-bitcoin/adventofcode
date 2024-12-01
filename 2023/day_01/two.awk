function digit2num(x){
#    if(x == "zero"){
#        return(0)
#    } else
    if(x == "one"){
        return("1ne")
    } else if(x == "two"){
        return("2wo")
    } else if(x == "three"){
        return("3hree")
    } else if(x == "four"){
        return("4our")
    } else if(x == "five"){
        return("5ive")
    } else if(x == "six"){
        return("6ix")
    } else if(x == "seven"){
        return("7even")
    } else if(x == "eight"){
        return("8ight")
    } else if(x == "nine"){
        return("9ine")
    }
}

function read_num(s){
    digit = "one|two|three|four|five|six|seven|eight|nine"
    while(match(s, digit)){
        num = digit2num(substr(s, RSTART, RLENGTH))
        sub(digit, num, s)
    }

   # print(s)
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
    #print(x)
    total += x
}

END{
    print(total)
}
