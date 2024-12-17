#I noticed that for a program to output the first few characters correctly, the value A encoded in base 8 needed to include a certain substring. So, I looped over values of A that included this substring. This helped me to find a bigger substring of A that is necessary to output more characters correctly. Continuing this process, I eventually found the value of A that was needed.




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
    A = 0
    n = 64
    #print(octal(n))
    #print(oct2dec(octal(n)))
    print(mainloop(A, B, C, Program))
}
function try_c(n,     x, y, m){
    x = n % 3
    n = int(n / 3)
    if(x == 0){
        y = 2
    } else if(x == 1){
        y = 3
    } else if(x == 2){
        y = 7
    }
    m = octal(n) "42523651427" y
    #print("try c " m)
    return(oct2dec(m))
}
function try_b(n,     x, y, m){
    x = n % 3
    n = int(n / 3)
    if(x == 0){
        y = 2
    } else if(x == 1){
        y = 3
    } else if(x == 2){
        y = 7
    }
    x1 = n % 3
    n = int(n / 3)
    if(x1 == 0){
        y1 = "5236"
    } else if(x1 == 1){
        y1 = "4457"
    } else if(x1 == 2){
        y1 = "6457"
    }

    m = (octal(n) y1 "51427" y) + 0
    #print("try b " n)
    return(oct2dec(m))
}
function try_a(n){
    #return(n)
    x = n % 6
    y = int(n/6)

    step = 170170 - 39098
    if(x == 0){
        extra = 0
    } else if(x == 1){
        extra = 1
    } else if(x == 2){
        extra = 5
    } else if(x == 3){
        extra = 420
    } else if(x == 4){
        extra = 421
    } else if(x == 5){
        extra = 424
    }
    return(39098 + (y*step) + extra)
}
function mainloop(A, B, C, Program,      a){
    while(1 == 1){
        if((A % 1000) == 0){
            #print("mainloop " A)
        }
        a = try_c(A)
        if(run(a, B, C, Program)){
            return(a)
        }
        A += 1
    }
}

function octal(X,      c, y){
    if(X == 0){
        return("")
    }
    c = (X % 8)""
    y = octal(int(X / 8))""
    return(y c)
}
function oct2dec(s){
    if(s == ""){return(0)}
    return((substr(s, length(s), 1)) + (8*(oct2dec(substr(s, 1, length(s)-1)))))
}

function run(a, b, c, program,       P, m, result){
    m = split(program, P, ",")
    output_pointer = 1
    a_start = a
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
            if(P[output_pointer] == (combo_val % 8)){
                if(output_pointer > 11){
                    oct = octal(a_start)
                    #print("partial match " oct)
                }
                output_pointer += 1
            } else {
                return(0)
            }
        } else if (opcode == 6){
            #bdv
            b = int(a/pow2(combo_val))
        } else if (opcode == 7){
            #cdv
            c = int(a/pow2(combo_val))%8
        } else {
            print("illegal opcode " opcode)
            return(0)
        }
            
    }
    if(output_pointer == (m+1)){
        return(1)
    } else {
        return(0)
    }
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
