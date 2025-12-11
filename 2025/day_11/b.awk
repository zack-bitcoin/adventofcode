{
    x = substr($1, 1, 3)
    Node[NR] = x
    peers = substr($0, 5)
    Data[x] = peers
    PathsFrom["out"] = 1
    PathsFFT["out"] = 0
    PathsDAC["out"] = 0
    PathsBoth["out"] = 0
    print("node " x ", peers: " peers)
}
END{
    loops = 0
    while(1){
	loops += 1
	print("mainloop")
	if("svr" in PathsFrom){
	    print("result: " PathsBoth["svr"])
	    exit
	}
	for(i=1; i<=NR; i++){
	    node = Node[i]
	    if(node in PathsFrom){
		
	    } else {
	    peers = Data[node]
	    #print("try node " node " with peers: " peers)
	    if(all_defined(peers)){
		sum = sum_up(peers)
		sum_fft = sum_up_fft(peers)
		sum_dac = sum_up_dac(peers)
		sum_both = sum_up_both(peers)
		if(node == "fft"){
		    PathsFrom[node] = 0
		    PathsFFT[node] = sum_fft + sum
		    PathsDAC[node] = 0
		    PathsBoth[node] = sum_both + sum_dac
		} else if(node == "dac"){
		    PathsFrom[node] = 0
		    PathsFFT[node] = 0
		    PathsDAC[node] = sum_dac + sum
		    PathsBoth[node] = sum_both + sum_fft
		} else {
		    PathsFrom[node] = sum
		    PathsFFT[node] = sum_fft
		    PathsDAC[node] = sum_dac 
		    PathsBoth[node] = sum_both
		}
		
                print("node " node " has  " sum "," sum_fft "," sum_dac "," sum_both " paths" peers)
	    }
	    }
	}
    }
}
function sum_up_fft(peers,   M, P, sum, i){
    M = split(peers, P, " ")
    sum = 0
    for(i=1; i<=M; i++){
	sum += PathsFFT[P[i]]
    }
    return(sum)
}
function sum_up_dac(peers,  M, P, sum, i){
    M = split(peers, P, " ")
    sum = 0
    for(i=1; i<=M; i++){
	sum += PathsDAC[P[i]]
    }
    return(sum)
}
function sum_up_both(peers,      M, P, sum, i){
    M = split(peers, P, " ")
    sum = 0
    for(i=1; i<=M; i++){
	sum += PathsBoth[P[i]]
    }
    return(sum)
}
function sum_up(peers,     M, P, sum, i){
    M = split(peers, P, " ")
    sum = 0
    for(i=1; i<=M; i++){
	sum += PathsFrom[P[i]]
    }
    return(sum)
}
function all_defined(peers,    M, P, i){
    M = split(peers, P, " ")
    for(i=1; i<=M; i++){
	if(!(P[i] in PathsFrom)){
	    return(0)
	}
    }
    return(1)
}

