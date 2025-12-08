#rank 2448
#time 40:47

BEGIN{
    #PairsToConnect = 10
    PairsToConnect = 1000
}

{
    split($0, A, ",")
    Data[NR, 1] = A[1]
    Data[NR, 2] = A[2]
    Data[NR, 3] = A[3]
}

END{
    print("many nodes = " NR)
    print("make pairs")
    file = "pairs.txt"
    system("rm " file)
    for(i=1; i<=(NR-1); i++){
	for(j=i+1; j<=NR; j++){
	    D = distance(Data[i, 1], Data[i, 2], Data[i, 3],
			 Data[j, 1], Data[j, 2], Data[j, 3])
	    print(D " " i " " j) >> file
	}
    }
    print("sort pairs")
    file2 = "sorted_pairs.txt"
    system("rm " file2)
    system("cat " file " | sort -n > " file2)
    circuits = ""
    for(i=1; i<=NR; i++){
	circuits = circuits ";" i
    }
    circuits = substr(circuits, 2)
    print("connect pairs")
    for(i=1; i<=PairsToConnect; i++){
	#print(circuits)
	getline line < file2
	#print(line)
        split(line, A, " ")
        circuits = connect(A[2], A[3], circuits)
    }
    print(circuits)
    M = split(circuits, A, ";")
    sf = "sizes.txt"
    system("rm " sf)
    sizes = ""
    for(i=1; i<=M; i++){
	N = split(A[i], B, ",")
	print(N) >> sf
    }
    ss = "sorted_sizes.txt"
    system("cat "sf " | sort -r -n > "ss)
    acc = 1
    for(i=1; i<=3; i++){
	getline line < ss
	acc = acc * line
    }
    print("result " acc)
    #connect the 10 shortest connections. multiply the sizes of all the circuits.
}

function connect(n, m, circuits,     M, A, i, Ca, Cb, circuits2){
    #print("connect " n " " m " in " circuits)
    M = split(circuits, A, ";")
    circuits2 = ""
    combo = ""
    for(i=1; i<=M; i++){
	Ca = contains(A[i], n)
	Cb = contains(A[i], m)
	if(Ca && Cb){
	    return(circuits)
	} else if(Ca || Cb){
	    combo = combo "," A[i]
	} else {
	    circuits2 = circuits2 ";" A[i]
	}
    }
    #print("combo " combo)
    circuits2 = substr(circuits2, 2) ";" substr(combo, 2)
    return(circuits2)
}

function contains(C, n,         M, A, i){
    M = split(C, A, ",")
    for(i=1; i<=M; i++){
	#print("contains " A[i] " " n)
       if(A[i] == n){
           return(1)
       }
    }
    return(0)
}

function distance(x1, y1, z1, x2, y2, z2,     xd, yd, zd){
    xd = ((x2-x1) ^ 2)
    yd = ((y2-y1) ^ 2)
    zd = ((z2-z1) ^ 2)
    return(xd + yd + zd)
}
