BEGIN{
    many_rules = 0
}

/:/ {
    split($0, a, ": ")
    Wires[a[1]] = a[2]+0
}

/->/ {
    many_rules += 1
    Rules[many_rules] = $0
    split($0, a, " ")
    if(starts_with_z(a[5])){
        highest_z = max(highest_z, substr(a[5], 2, 2)+0)
    }
}

END{
    print("highest z: " highest_z)
    #print("many rules " many_rules)
    #update()
    #read_value()
    #Rules = 0
    print(update_loop())
}
function max(a, b){
    if(a > b){return(a)}
    else{return(b)}
}
            
function update_loop(){
    #print("update loop")
    if(all_defined()){
        return(read_value())
    }
    update()
    return(update_loop())
}
function read_value(){
    print("read value")
    acc = 0
    for(i=highest_z; i>=0; i--){
        if(i < 10){
            key = "z0" i
        } else {
            key = "z" i
        }
        acc = 2*acc + (Wires[key])
    }
    return(acc)
}
function starts_with_z(s){
    return(substr(s, 1, 1) == "z")
}
function all_defined(      i, rule, a, r){
    #print(" all defined")
    for(i=1; i<= many_rules; i++){
        rule = Rules[i]
        split(rule, a, " ")
        r = a[5]
        #print(r)
        if(!(r in Wires)){
            return(0)
        }
    }
    return(1)
}
function update(      i, rule, a, v1, v2, r, op){
    #print("update")
    for(i=1; i<= many_rules; i++){
        #print("update inner")
        rule = Rules[i]
        split(rule, a, " ")
        v1 = a[1]
        v2 = a[3]
        r = a[5]
        #print(r, v1, v2)
        op = a[2]
        if((v1 in Wires) && (v2 in Wires)){
            #print("update 3 " r, op, v1, v2, apply_op(op, Wires[v1], Wires[v2]))
            Wires[r] = apply_op(op, Wires[v1], Wires[v2])
        }
    }
}

function apply_op(op, v1, v2){
    #print("apply op " op, v1, v2)
    if(op == "AND"){
        return((v1 == 1) && (v2 == 1))
    }
    if(op == "OR"){
        return((v1 == 1) || (v2 == 1))
    }
    if(op == "XOR"){
        if((v1 == 1) && (v2 == 1)){
            return(0)
        }
        if((v1 == 0) && (v2 == 0)){
            return(0)
        }
        return(1)
    }
    print("impossible error")
}
