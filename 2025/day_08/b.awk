#rank 2457
#time 50:37
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
    while(!(many_circuits == 2)){
	getline line < file2
        split(line, A, " ")
	last_connection_1 = A[2]
	last_connection_2 = A[3]
        circuits = connect(A[2], A[3], circuits)
	many_circuits = split(circuits, A, ";")
    }
    First = A[1]
    c=1
    while(c){
	getline line < file2
	split(line, A, " ")
	if(A[2] == First){
	    Second = A[3]
	    c = 0
	} else if(A[3] == First){
	    Second = A[2]
	    c = 0
	}
    }
    print("result: " Data[First, 1] * Data[Second, 1])
}
function connect(n, m, circuits,     M, A, i, Ca, Cb, circuits2){
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
    circuits2 = substr(circuits2, 2) ";" substr(combo, 2)
    return(circuits2)
}
function contains(C, n,         M, A, i){
    M = split(C, A, ",")
    for(i=1; i<=M; i++){
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
