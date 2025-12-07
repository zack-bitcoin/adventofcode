#rank 1205
#time 14:25
/S/ {
    Cols = length($0)
    for(i=1; i<=Cols; i++)
	if("S" == substr($0, i, 1))
	    Beams[2, i] = 1
}
{
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
