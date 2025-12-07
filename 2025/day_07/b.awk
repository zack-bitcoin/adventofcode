#rank 1886
#time 29:00
/S/ {
    Cols = length($0)
    for(i=1; i<=Cols; i++)
	if("S" == substr($0, i, 1))
	    Beams[2, i] = 1
}
{
    for(i=1; i<=Cols; i++){
	if(Beams[NR, i] && (Beams[NR, i] > 0)){
	    letter = substr($0, i, 1)
	    if(letter == "."){
		Beams[NR+1, i] += Beams[NR, i]
	    } else if(letter == "^"){
		Beams[NR+1, i+1] += Beams[NR, i]
		Beams[NR+1, i-1] += Beams[NR, i]
	    }
	}
    }
}
END{
    for(i=1; i<=Cols; i++){
	total += Beams[NR+1, i]
    }
    print("result: " total)
}
