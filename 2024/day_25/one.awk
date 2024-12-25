BEGIN{
    key_number = 0
    lock_number = 0
    value = ""
    mode = "between"
}

/#####/ {
    if(mode == "between"){
        mode = "lock"
    }
}

/...../ {
    if(mode == "between"){
        mode = "key"
    }
}

/^$/ {
    #print("empty line")
    value = read_value(Values)
    for(i in Values){
        delete Values[i]
    }
    if(mode == "key"){
        Key[key_number] = value
        key_number += 1
    } else if(mode == "lock"){
        Lock[lock_number] = value
        lock_number += 1
    }
    mode = "between"
    height = 0
}

/[\.#]{5}/ {
    if(mode == "between"){
        print("impossible error")
    } else if(mode == "lock"){
        for(i=1; i<=5; i++){
            letter = substr($0, i, 1)
            if((letter == ".") && (!(i in Values))){
                    Values[i] = height-1
            }
        }
    } else if(mode == "key"){
        for(i=1; i<=5; i++){
            letter = substr($0, i, 1)
            if((letter == "#") && (!(i in Values))){
                    Values[i] = 6-height
                }
        }

    }
    height += 1
}

END{
    print("END")
    #print(key_number " " lock_number)
    for(k=0; k< key_number; k++){
        key = Key[k]
        for(l=0; l<lock_number; l++){
            lock = Lock[l]
            #print(key " " lock)
            if(fits(key, lock)){
                sum += 1
            }
        }
    }
    print(sum)
}
function fits(key0, lock0,      key, lock, i ){
    split(key0, key, ",")
    split(lock0, lock, ",")
    for(i=1; i<=5; i++){
        if((key[i]+lock[i])>5){return(0)}
    }
    return(1)
}
function read_value(Values,       value){
    value = Values[1]
    for(i=2; i<=5; i++){
        value = value "," Values[i]
    }
return(value)
}
