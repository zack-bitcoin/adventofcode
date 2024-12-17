/Register A/ {
    split($0, a, ":")
    A = a[2]
}
/Register B/ {
    split($0, a, ":")
    B = a[2]
}
/Register C/ {
    split($0, a, ":")
    C = a[2]
}
/Program/ {
    split($0, a, ":")
    Program = a[2]
}

END{
    print(A " " B " " C " : " Program)
    print(run(A, B, C, Program))
}

function run(a, b, c, program,       P, m, result){
    m = split(program, P, ",")
    result = ""
    for(i=1; i<=m; i += 2){
#i is instruction pointer
        opcode = P[i]+0
        operand = P[i+1]+0
        combo_val = combo(operand, a, b, c)
        #print("run " i " " opcode " " operand)
        if(opcode == 0){
            #adv
            #division
            a = int(a/pow2(combo_val))
        } else if (opcode == 1){
            #bxl
            #bitwise xor
            b = xor(b, operand)
        } else if (opcode == 2){
            #bst
            b = combo_val % 8
        } else if (opcode == 3){
            #jnz
            if(!(a == 0)){
                i = operand-1
            }
        } else if (opcode == 4){
            #bxc
            b = xor(b, c)
        } else if (opcode == 5){
            #out
            #print("out: " combo_val % 8)
            result = result "," (combo_val % 8)
        } else if (opcode == 6){
            #bdv
            b = int(a/pow2(combo_val))
        } else if (opcode == 7){
            c = int(a/pow2(combo_val))
        } else {
            print("illegal opcode " opcode)
            return(0)
        }
            
    }
    return(result)
}
function pow2(x){
    return(2 ^ x)
}

function combo(n, A, B, C) {
    #print("combo " n " " A " " B " "C)
    if(n < 4) {
        return(n)
    }
    if(n == 4) {
        return(A)
    }
    if(n == 5) {
        return(B)
    }
    if(n == 6) {
        return(C)
    }
    if(n == 7) {
        print("error. impossible combo value!")
        print(n " " A " " B " " C)
    }
}
