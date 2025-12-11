BEGIN{


}
{
    print("line " NR)
    L1 = substr($(NF), 2, length($(NF))-2)
    M = split($0, A, " ")
    s = ""
    for(i=2; i<=M-1; i++){
	button = substr(A[i], 2, length(A[i]) - 2)
	B[i-1] = button
	s = s " " button
    }
    many_buttons = M-2
    s = substr(s, 2)
    print(L1 "-" s)
    target_distance = 0
    M = split(L1, T, ",")
    for(i=1; i<=M; i++){
	target_distance += T[i]
    }
    print("target distance " target_distance)
    for(i=1; i<=many_buttons; i++){
	x = 0
	N = split(B[i], C, ",")
	for(j=1; j<=N; j++){
	    x += C[j]
	}
	button_magnitude[i] = x
	print("mag " i " " x)
    }

    P = partitions("", 1, many_buttons, button_magnitude, target_distance)
    print(P)
    
    #find combinations of button presses such that the magnitude ads up to the target distance. sort from minimum button presses. then find the first version that has correct lights.


    exit
}
	
function partitions(prefix, more, many_buttons, button_magnitude, target_distance){
    if(more == many_buttons){
	if((target_distance % button_magnitude[many_buttons]) == 0){
	    return(substr(prefix","int(target_distance  / button_magnitude[many_buttons])))
        }
    }
    

}
