{
    Data[NR] = $0
}

END{
    y = 1000000000000000000000000
    for(i=1; i<(NR-1); i++){
	x = Data[i] + Data[i+1] + Data[i+2]
	print("x is " x)
	if(x > y){
	    sum += 1
	}
	y = x
    }
    print("result: " sum)
}
