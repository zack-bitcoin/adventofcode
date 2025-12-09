BEGIN{
    T = 0
    top2 = 1
    data_file = ARGV[2]
}
(NR == 1){
    file = $0
    ln = 1
    while(getline line < file){
	#store every line of the input
	lines[ln] = line

	#store every word of every line, split by spaces.
	M = split(line, A, " ")
	words[ln, 0] = M
	for(i=1; i<=M; i++)
	    words[ln, i] = A[i]

	#store every letter of every line
	l = length(line)
	for(i=1; i<=l; i++)
	    letters[ln, i] = substr(l, i, 1)

	ln += 1
    }
    lines[0] = ln
}
(NR > 1){
    if(match($0, "#")){
	$0 = substr($0, 1, RSTART-1)
    }
    code = code " " $0
    #print("main run " $0)
}
END{
    gsub(/[ \t]+/, " ", code)
    #print("run code: " code)
    MaxSize = split(code, Unused, " ")
    run(substr(code, 2))
}

function word(W, i, A,    M, C, k){
    #print("word " W " " S[T] " " T)
    if(match(W, /^-?[0-9]+$/)){
	S[T+1] = W+0
	T += 1
    } else if(W == "split"){
	letter = " "
	if(S[T] == 1)
	    letter = ","
	if(S[T] == 2)
	    letter = "-"
	M = split(S[T-1], C, letter)
	for(k=1; k<=M; k++)
	    S[T+k-1] = C[k]
	S[T+M] = M
    } else if(W == "substr"){
	S[T-1] = substr(S[T-1], S[T])
	T -= 1
    } else if(W == "substr2"){
	#print("substr("S[T-2]", "S[T-1]", "S[T]")")
	S[T-2] = substr(S[T-2], S[T-1], S[T])
	T -= 2
    } else if(W == "append"){
	S[T-1] = S[T-1] S[T]
	T -= 1
    } else if(W == "dup"){
	S[T+1] = S[T]
	T += 1
    } else if(W == "swap"){
	x = S[T-1]
	S[T-1] = S[T]
	S[T] = x
    } else if(W == "rot"){
	x = S[T-2]
	S[T-2] = S[T-1]
	S[T-1] = S[T]
	S[T] = x
    } else if(W == "tuck"){
	x = S[T-2]
	S[T-2] = S[T]
	S[T] = S[T-1]
	S[T-1] = x
    } else if(W == "drop"){
	T -= 1
    } else if(W == "2dup"){
	S[T+1] = S[T-1]
	S[T+2] = S[T]
	T += 2
    } else if(W == "2swap"){
	x = S[T-1]
	y = S[T]
	S[T-1] = S[T-3]
	S[T] = S[T-2]
	S[T-3] = x
	S[T-2] = y
    } else if(W == "pick"){
	S[T] = S[T-S[T]]
    } else if(W == "R@"){
	S[T + 1] = R[T]
	T += 1
    } else if(W == "R>"){
	S[T + 1] = R[T]
	T += 1
	top2 -= 1
    } else if(W == ">R"){
	R[top2 + 1] = S[T]
	T -= 1
	top2 += 1
    } else if(W == "."){
	print(S[T])
	T -= 1
    } else if(W == ".s"){
	#print("T is " T)
	print_stack()
    } else if(W == "+"){
	S[T-1] = S[T-1] + S[T]
	T -= 1
    } else if(W == "-"){
	S[T-1] = S[T-1] - S[T]
	T -= 1
    } else if(W == "*"){
	S[T-1] = S[T-1] * S[T]
	T -= 1
    } else if(W == "/"){
	S[T-1] = int(S[T-1] / S[T])
	T -= 1
    } else if(W == "%"){
	S[T-1] = S[T-1] % S[T]
	T -= 1
    } else if(W == ">"){
	S[T+1] = S[T-1] > S[T]
	T += 1
    } else if(W == "<"){
	S[T+1] = S[T-1] < S[T]
	T += 1
    } else if(W == "="){
	S[T] = (S[T-1] == S[T])
    } else if(W == "line"){
	S[T] = lines[S[T]]
    } else if(W == "word"){
	S[T-1] = words[S[T-1], S[T]]
	T -= 1
    } else if(W == "letter"){
	S[T-1] = letters[S[T-1], S[T]]
	T -= 1
    #} else if(W == ":"){
    } else if(W == ":"){
	#print("defining " A[i] " " A[i+1])
	name = A[i+1]
	i += 2
	if(name in Variables){
	    print("error, name " name " is already used for a variable definition.")
	}
	if(name in Functions){
	    print("error, function " name " is already defined")
	    exit
	}
	nl = A[i]
	s = ""
	while((i < MaxSize) && !(nl == ";")){
	    #print("looking for colon loop " nl)
	    s = s " " nl
	    i += 1
	    nl = A[i]
        }
	#print("defined function " name " as " s)
	Functions[name] = s
    } else if(W == "call"){
	#print("called a function: " S[T])
	fun = Functions[S[T]]
	#print("called a function defined: " fun)
	T -= 1
	run(fun)
    } else if(W == "!"){
	if(S[T] in Variables){
	    Variables[S[T]] = S[T-1]
	    T -= 2
	} else {
	    print("error. " S[T] " is not a defined variable.")
	    exit
	}
    } else if(W == "@"){
	S[T] = Variables[S[T]]
    } else if(W == "var"){
	if(A[i+1] in Variables){
	    print("error. " A[i+1] " is already a defined variable.")
	    exit
	}
	if(A[i+1] in Functions){
	    print("error. " A[i+1] " is already a defined function.")
	    exit
	}
	Variables[A[i+1]] = 0
	i += 1
    } else if(W == "then"){
    } else if(W in Variables){
	#print("loaded variable name onto stack " W)
	S[T+1] = W
	T += 1
    } else if(W in Functions){
	#print("loaded function name onto stack" W)
	S[T+1] = W
	#print("T is " T)
	T += 1
	#print("T is " T)
    } else if(!(W)){
	print("called nothing")
    } else {
	print("undefined command >" W "<")
	exit
    }
    return(i)
}

function run(s,               A, M, k, t){
    #print("run top: " s)
    if(T < 0){
	print("underflow error " T " " i " " s)
	exit
    }
    M = split(s, A, " ")
    for(i=1; i<=M; i++){
	if(A[i] == "return"){
	    i = M+1
	} else if(A[i] == "recurse"){
	    i = 0
	}else if(A[i] == "if"){
	    if(S[T] == 0){
		while(((!(A[i] == "else")) && (!(A[i] == "then")))){
		    #print("while 1 " i A[i])
		    i++
		}
	    }
	    T -= 1
	} else if(A[i] == "else"){
	    while(!(A[i] == "then")){
		#print("while 2")
		i++
	    }
	} else if(A[i] == ".\""){
	    t = ""
	    i++
	    while(!(A[i] == "\"")){
		#print("while 3")
		t = t " " A[i]
		i++
	    }
	    S[T+1] = substr(t, 2)
	    T += 1
	} else {
	    i =  word(A[i], i, A)
	}
    }
    #print("run bottom " i " " S[1] " " S[2])
    return(i)
}

function print_stack(        s, k){
    s = ""
    for(k=1; k<=T; k++){
	s = s ", " S[k]
    }
    print(substr(s, 2))
}
