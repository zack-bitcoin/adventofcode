BEGIN{

}
{
    x = substr($1, 1, 3)
    Node[NR] = x
    peers = substr($0, 5)
    Data[x] = peers
    PathsFrom["fft"] = 1
    print("node " x ", peers: " peers)
}

END{
    loops = 0
    while(1){
	loops += 1
	if(loops > 20){
	    print("more than 20 loops")
	    exit
	}
	print("mainloop")
	if("svr" in PathsFrom){
	    print("result: " PathsFrom["svr"])
	    exit
	}
	for(i=1; i<=NR; i++){
	    node = Node[i]
	    if(node in PathsFrom){
		
	    } else {
	    peers = Data[node]
	    #print("try node " node " with peers: " peers)
	    sum = all_defined(peers)
	    if(all_defined(peers)){
		sum = sum_up(peers)
		PathsFrom[node] = sum
                print("node " node " has  " sum " paths" )
	    }
	    }
	}
    }
}
function sum_up(peers){
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
        #print("all_defined " P[i])
	if(!(P[i] in PathsFrom)){
	    return(0)
	}
    }
    return(1)
}

