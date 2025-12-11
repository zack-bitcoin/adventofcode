#rank 6615
#time 2:32:57

BEGIN{
    #print(choose(3, "1 2 3 4 5 6"))
    #print(make_paths(3, 6))
    #exit
}

{
    print("line " NR)
    L1 = substr($1, 2, length($1)-2)
    M = split($0, A, " ")
    s = ""
    for(i=2; i<=M-1; i++){
	s = s " " substr(A[i], 2, length(A[i]) - 2)
    }
    #print("min presses " L1 " " substr(s, 2))
    partial = min_presses(L1, substr(s, 2))
    print(" partial : " partial)
    sum += partial
}
END{
    print("result: " sum)
}


function min_presses(result, buttons,       A, i, many_buttons, B, many_bits, j, many_lights, s, lr, result2){
    print("min presses " result " " buttons)
    many_lights = length(result)
    many_buttons = split(buttons, A, " ")
    for(i=1; i<=many_buttons; i++){
        many_bits = split(A[i], B, ",")
	s = ""
	for(j=1; j<=many_lights; j++){
	    if(is_in(j-1, many_bits, B)){
		s = s "1"
	    } else {
		s = s "0"
	    }
	}
	A[i] = s
    }
    lr = length(result)
    result2 = ""
    for(i=1; i<=lr; i++){
	if(substr(result, i, 1) == "."){
	    result2 = result2 "0"
	} else {
	    result2 = result2 "1"
	}
    }
    #print("search " result2 " " many_buttons " ")
    #for(i=1; i<=many_buttons; i++)
	#print(A[i])
    return(search(result2, many_buttons, A))#search("0110", 6, {1:0010, 2:1010, ...})
}

function is_in(n, M, A,     i){
    for(i=1; i<=M; i++){
	if(n == A[i]){
	    return(1)
	}
    }
    return(0)
}

function xor(s1, s2,       s3, ls, i){
    ls = length(s1)
    s3 = ""
    for(i=1; i<=ls; i++){
	if(substr(s1, i, 1) == substr(s2, i, 1)){
	    s3 = s3 "0"
	} else {
	    s3 = s3 "1"
	}
    }
    return(s3)
}

function search(goal, M, A,       steps){
    print("searching for: " goal)#0110
    #print("have " M " many buttons to search with ")
    #for(i=1; i<=M; i++){
	#print(A[i])#0010
    #}
    steps = 1
    while(1){
#	if(steps > 3){
#            print(goal " " M)
#            print("impossible error in example")
#	    exit
#	}
	print("searching many steps " steps)
	if(steps > M){
	    print("goal is impossible")
	    exit
	}
	if(search2(steps, goal, M, A)){
	    return(steps)
	} else {
	    steps+= 1
	}
    }
}
function combos(s1, s2,     M, N, A, B, i, j, s){
    M = split(s1, A, " ")
    N = split(s2, B, " ")
    s = ""
    for(i=1; i<=M; i++){
	for(j=1; j<=N; j++){
	    s = s " " A[i] B[j]
	}
    }
    #print("combos s1: " s1 " s2: " s2 " s3: " s)
    return(substr(s, 2))
}

function make_paths(steps, M,        i) {
    s = ""
    for(i=1; i<=M; i++){
	s = s " " i
    }
    print("make paths " steps " - " s)
    return(choose(steps, substr(s, 2)))
}
function choose(n, t,        i, letter, s2, c, M, A, t2){
    if(n == 1){return(t)}
    #print("choose " n " - " t)
    M = split(t, A, " ")
    t2 = ""
    for(i=1; i<=M; i++){
	#letter = substr(A[i], i, 1)
	letter = A[i]
	#s2 = substr(s, 1, i-1) substr(s, i+1)
	#s2 = substr(s, i+1)
	s2 = ""
	for(j=i+1; j<=M; j++){
	    s2 = s2 " " A[j]
	}
	#print("in choose " letter " " s2)
	c = choose(n-1, s2)
	#print("c : " c)
	t2 = t2 " " combine(letter, c)
    }
    return(substr(t2, 2))
}
#combine("A", "1 3 4 5 6")
function combine(letter, s,     M, A, t, i){
    M = split(s, A, " ")
    t = ""
    for(i=1; i<=M; i++){
	t = t " " letter","A[i]
    }
    return(substr(t, 2))
}

function repeated_letter(s,      l, i, j){
    l = length(s)
    for(i=1; i<=(l-1); i++){
	for(j=i+1; j<=l; j++){
	    if((substr(s, i, 1)) == (substr(s, j, 1))){
		return(1)
	    }
	}
    }
    return(0)
}

function search2(steps, goal, ManyButtons, Buttons,         N, B, i, paths){
    paths = make_paths(steps, ManyButtons)
    #print("search2 steps " steps " M: " ManyButtons " paths: " paths)
    N = split(paths, B, " ")
    for(i=1; i<=N; i++){
	if(check_option(goal, B[i], ManyButtons, Buttons)){
	    print("option worked " B[i])
	    return(1)
	}
    }
    return(0)
}

function check_option(goal, path, many_buttons, Buttons,        s, i, step, button){
    #print("check_option goal: " goal " path: " path)
    s = ""
    MP = split(path, P, ",")

    for(i=1; i<=length(goal); i++){
	s = s "0"
    }
    #for(i=1; i<=length(path); i++){
    for(i=1; i<=MP; i++){
	#step = substr(path, i, 1)
	step = P[i]
	#print("xor combo " s " step: " step " path: "  path " " Buttons[substr(path, i, 1)])
	button = Buttons[step]
	s = xor(s, button)
    }
    print("check_option goal: " goal " path: " path " result: " s)
    return(s == goal)
}
