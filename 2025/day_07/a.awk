#rank 1205
#time 14:25

BEGIN{

}

/S/ {
    print("S zone")
    Cols = length($0)
    for(i=1; i<=Cols; i++){
	print("letter " substr($0, i, 1))
	if("S" == substr($0, i, 1)){
	    print("added beam " 2 " " i)
	    Beams[2, i] = 1
	}
    }
}
{
    #print("line " $0)
    for(i=1; i<=Cols; i++){
	if(Beams[NR, i] == 1){
	    letter = substr($0, i, 1)
	    if(letter == "."){
		Beams[NR+1, i] = 1
	    } else if(letter == "^"){
		splits += 1
		Beams[NR+1, i+1] = 1
		Beams[NR+1, i-1] = 1
	    }
	}
    }
}

END{
    print("result: " splits)
}
