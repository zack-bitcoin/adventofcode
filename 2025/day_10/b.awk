BEGIN{
    #print(partition("", 3, 5))
    #exit
}
{
    print("line " NR)
    L1 = substr($(NF), 2, length($(NF))-2)
    M = split($0, A, " ")
    s = ""
    for(i=2; i<=M-1; i++){
	s = s " " substr(A[i], 2, length(A[i]) - 2)
    }
    partial = min_presses(L1, substr(s, 2), 1)
    print(" partial : " partial)
    sum += partial
}
END{
    print("result: " sum)
}

function min_presses(result, buttons, presses,      many_buttons, start, many_joltages, i, part, P, C){
    print("min presses " presses)
    #if(presses > 12){
	#print("error bad software")
	#exit
    #}
    many_buttons = split(buttons, B, " ")
    start = ""
    many_joltages = split(result, J, ",")
    for(i=1; i<=many_joltages; i++){
        start = start",0"
    }
    part = partition("", many_buttons, presses)
    P = split(part, C, " ")
    for(i=1; i<=P; i++){
	if(finished(result, many_buttons, B, C[i])){
	    return(presses)
	}
    }
    return(min_presses(result, buttons, presses+1))
}

function fact(x){
    if(x > 0){
	return(x * fact(x-1))
    } else {
	return(1)
    }
}

function partition(prefix, bins, balls,    s, i){
    #list the ways you can insert balls many balls into bins many bins.
    #put all the balls in a line, and draw bins-1 dividers to split them up into bin groups. so, now there are balls+bins-1 things in a line, and you are choosing how to order them. (balls+bins-1) choose (bins-1)
    #x = bins+balls-1
    #(fact(x)/fact(bins)/fact(balls-1))
    #print("partition prefix " prefix " bins " bins " balls " balls)
    if(bins==1){return(substr(prefix","balls, 2))}
    s = ""
    for(i=0; i<=balls; i++){
	#first bin has i balls
	s = s " " partition(prefix ","i, bins-1, balls-i)
    }
    return(s)
    #print("partition " bins " " balls)
    #exit
}
function unused(){
    r = 1
    for(i = balls; i<=(balls-bins); i++){
	print("* " i)
	r = r * i
    }
#    for(i=1; i<=(balls-bins); i++){
#	print("/ " i)
#	r = r / i
#    }
    return(r)
}
function finished(result, many_buttons, B, part){
    #print("finished " part)
    #print("finished " result "-" many_buttons "-" part)
    many_joltages = split(result, _, ",")
    M = split(part, A, ",")
    x = ""
    for(i=1; i<=many_joltages; i++){
	x = x",0"
    }
    x = substr(x, 2)
    #press buttons according to this version of the partitioning.
    split(part, P, ",")

    for(i=1; i<=M; i++){
        if(P[i]){
	    x = press_button(x, B[i], P[i])
	}
    }
    #print(result "=" x)
    if(result == x){return(1)}
    return(0)
}

function min_presses_old(result, buttons,       many_buttons, start, many_joltages){
    print("result " result)
    print("buttons: " buttons)


    

    exit
    many_buttons = split(buttons, B, " ")
    start = ""
    many_joltages = split(result, J, ",")
    for(i=1; i<=many_joltages; i++){
        start = start",0"
    }
    start = substr(start, 2)
    min_presses2(start, result, many_joltages, B, many_buttons, 0)
}
function min_presses2(start, result, manyJ, B, manyB, presses,       r, i, x, y){
    #print("min presses 2 " start)
    if(start == result){
	#print("found a combo! " presses " "start " _ " result)
	return(presses)
    }
    if(out_of_bounds(start, result)){
	#print("out of bounds")
	return(10000000)
    }
    r = 1000000000
    #print("keep trying")
    for(i=1; i<=manyB; i++){
	x = press_button(start, B[i])
	y = min_presses2(x, result, manyJ, B, manyB, presses+1)
	r = min(r, y)
    }
    return(r)
}
function out_of_bounds(start, result,     M, A, B, i){
    M = split(start, A, ",")
    split(result, B, ",")
    for(i=1; i<=M; i++){
	if(A[i] > B[i]){return(1)}
    }
    return(0)
}
function state_bump(state, n, multiplier,       M, A, i){
    M = split(state, A, ",")
    A[n+1] += multiplier
    s = ""
    for(i=1; i<=M; i++){
	s = s "," A[i]
    }
    return(substr(s, 2))
}
function press_button(state, button, multiplier,        M, B, i){
    if(!(button)){ exit}
    #print("press button " state "_" button)
    M = split(button, B, ",")
    for(i=1; i<=M; i++){
	state = state_bump(state, B[i], multiplier)
    }
    #print("press button end " state )
    return(state)
}
function min(a, b){
    if(a < b){return(a)}
    return(b)
}
