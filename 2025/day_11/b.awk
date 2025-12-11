BEGIN{

}
{
    x = substr($1, 1, 3)
    Node[NR] = x
    peers = substr($0, 5)
    Data[x] = peers
    PathsOut["out"] = 1
    FullPathsOut["out"] = "out"
    #PathsDAC["dac"] = 1
    #Pathsfft["fft"] = 1
    print("node " x ", peers: " peers)
}

END{
    loops = 0
    loading = 1
    while(loading){
	loops += 1
	if(loops > 20){
	    print("more than 20 loops")
	    exit
	}
	if("svr" in PathsOut){
	    #print("result 1: " PathsOut["svr"])
	    loading = 0
	} else {
	for(i=1; i<=NR; i++){
	    node = Node[i]
	    if(node in PathsOut){
		
	    } else {
	    peers = Data[node]
	    #print("try node " node " with peers: " peers)
	    sum = all_defined(peers)
	    if(all_defined(peers)){

		M = split(peers, P, " ")
		sum = 0
		s = ""
		for(i=1; i<=M; i++){
		    sum += PathsOut[P[i]]
		    s = s ";" combine(node, FullPathsOut[P[i]])
		}

		PathsOut[node] = sum
                FullPathsOut[node] = substr(s, 2)
                print("node " node " has " sum " paths" )
	    }
	    }
	}
	}
    }
    for(i=1; i<=NR; i++){
	print("node " Node[i] " paths: " FullPathsOut[Node[i]])
    }
    s_paths = FullPathsOut["svr"]
    M = split(s_paths, P, ";")
    sum = 0
    for(i=1; i<=M; i++){
	print("path: " P[i])
        if(match(P[i], /fft/) && match(P[i], /dac/)){
            sum += 1
}
    }
    print("result: " sum)
}
function combine(step, paths,     P, M, i, s){
    M = split(paths, P, ";")
    s = ""
    for(i=1; i<=M; i++){
	s = s ";"step","P[i]
    }
    return(substr(s, 2))
}
function unused_sum_up(peers){
    M = split(peers, P, " ")
    sum = 0
    for(i=1; i<=M; i++){
	sum += PathsOut[P[i]]
    }
    return(sum)
}
function all_defined(peers,    M, P, i){
    M = split(peers, P, " ")
    for(i=1; i<=M; i++){
        #print("all_defined " P[i])
	if(!(P[i] in PathsOut)){
	    return(0)
	}
    }
    return(1)
}
