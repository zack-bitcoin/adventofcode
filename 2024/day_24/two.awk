#the way I ended up doing it.  wrote a bunch of tests, then I edited the input file to see if it caused more tests to pass.
#I changed the order of the gates in the input file to make it clearer which gates are used in each adder. Each adder is 2 XOR, 2 AND, and 1 OR. A little different than the standard adder, but similar.
#You can tell something is wrong when a gate can't fill in the pattern.
#trial and error fixes it quick, there are tests to know if you got it right.


#jgb,rkf,rrs,rvc,vcg,z09,z20,z24

#adder

#normal
# z_n = a_n xor b_n xor c_n-1
# c_n = (a_n or b_n) and (c_n-1 or/xor (a_n xor b_n))

#aoc
# z_n = a_n xor b_n xor c_n-1
# c_n = (a_n and b_n) or ((a_n xor b_n) and c_n-1)


#221 logic gates used
#45 output wires, 90 input wires.


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
    copy(Wires, DefaultWires)
    copy(Rules, DefaultRules)
    print("highest z: " highest_z)
    #print("many rules " many_rules)
    #update()
    #read_value()
    #Rules = 0
#    set("x", 0)
#    set("y", 0)
#    print(update_loop())
    for(i=1; i<= many_rules; i++){
        print("main loop: " i)
        for(j=1; j<= i; j++){
            rule1 = Rules[i]
            rule2 = Rules[j]
            rule1_ = rule1
            rule2_ = rule2
            split(rule1, a1, " ")
            split(rule2, a2, " ")
            sub(rule1, a1[5], a2[5])
            sub(rule2, a2[5], a1[5])
            Rules[i] = rule1
            Rules[j] = rule2
            passed = tests()
            print("passed " passed)
            if(passed > 5){
                print("helpful switch: " rule1 ":" rule2)
            }
            Rules[i] = rule1_
            Rules[j] = rule2_
        }
    }
    print(tests())
}
function copy(A, B,      i) {
    for(i in B){
        delete B[i]
    }
    for(i in A){
        B[i] = A[i]
    }
}
function tests(      s, m, a, i, sum, a1, a2, a3, a4){
    print("tests")
    a1 = 512
    a2 = 1048576
    a3 = 16777216
    a4 = 2147483648
    s = "17592186044415 17592186044415,17592186044415 17592186044415,4294967295 4294967295,4294967295 4294967295,1 1,5 5,10 10,15 15,31 31,"a1" 0,"a1" "a1","a2" 0,"a3" 0,0 "a1",0 "a2",0 "a3",0 "a4","a1" "a2","a1" "a3","a1" "a4","a2" "a2","a2" "a3","a2" "a4","a3" "a3","a3" "a4","a4" "a4","a1+a2" "0","a1+a3" "0","a1+a4" "0","0" "a1+a2
    #s = "1 1,5 5,10 10,15 15,31 31,"a1" 0,"a1" "a1","a2" 0,"a3" 0,0 "a1",0 "a2",0 "a3
    #s = "1 1,5 5,512 0,512 512,1048576 0,16777216 0,0 512,0 1048576,0 16777216,0 2147483648,512 1048576,512 16777216,512 2147483648"
    m = split(s, a, ",")
    for(i=1; i<=m; i++){
        copy(DefaultWires, Wires)
        split(a[i], b, " ")
        sum += test(b[1]+0, b[2]+0)
    }
    return(sum)
}
function test(x, y){
    #print("test " x " " y)
    set("x", x)
    set("y", y)
    #print("is: " update_loop(), "should be: " x+y)
    return(update_loop() == (x+y))
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
function read_value(         acc, accx, accy, i, key, xkey, ykey){
    acc = 0
    accx = 0
    accy = 0
    for(i=highest_z; i>=0; i--){
        if(i < 10){
            key = "z0" i
            xkey = "x0" i
            ykey = "y0" i
        } else {
            key = "z" i
            xkey = "x" i
            ykey = "y" i
        }
        acc = 2*acc + (Wires[key])
        accx = 2*accx + (Wires[xkey])
        accy = 2*accy + (Wires[ykey])
        #print(key " " Wires[key])
    }
#    print("X: " accx)
#    print("Y: " accy)
    return(acc)
}
function set(letter, n,         i, key){
    for(i=0; i<highest_z; i++){
        if(i <10){
            key = letter "0" i
        } else {
            key = letter i
        }
        Wires[key] = n%2
        n = int(n/2)
    }
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

