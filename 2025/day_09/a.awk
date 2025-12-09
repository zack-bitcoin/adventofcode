#rank 2288
#time 11:15

{
    split($0, A, ",")
    Data[NR, 1] = A[1]
    Data[NR, 2] = A[2]
}

END{
    for(i=1; i<=( NR-1); i++){
	for(j=i+1; j<(NR); j++){
	    size = (abs(Data[i, 1] - Data[j, 1]) + 1) * (abs(Data[i, 2] - Data[j, 2]) + 1)
	    if(size > max_r){
		max_r = size
	    }
	}
    }

    print("result: " max_r)
}


function max(a, b){
  if(a > b){return(a)}
return(b)
}
function abs(a){
    if(a < 0){ return(-a)}
    return(a)
}
