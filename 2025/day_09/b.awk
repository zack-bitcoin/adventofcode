#rank 6308
#time 5:56:56
BEGIN{
}
{
    oldA1 = A[1]
    oldA2 = A[2]
    split($0, A, ",")
    Data[NR, 1] = A[1]
    Data[NR, 2] = A[2]
    Red[A[1], A[2]] = 1
    old_direction = direction
}
#concave: 7,3 and 9,5
(NR > 1){
    distance = abs(y-A[2]) + abs(x-A[1])
    if(distance > 10000){
	print("DISTANCE " distance " " x","y " " A[1]","A[2])
	print(A[1], A[2])
    }
    if(x == A[1]){
	#vertical line
	y1 = min(y, A[2])
	y2 = max(y, A[2])
	for(i=y1; i<=y2; i++){
	    Path[x, i] = 1
	    Pathx[x] = Pathx[x] " " i
	    Pathy[i] = Pathy[i] " " x
	    if(A[2] > y){
		DownPath[x, i] = 1
		direction = "0,1"
	    } else if(A[2] < y){
		UpPath[x, i] = 1
		direction = "0,-1"
	    }
	}
    } else if(y == A[2]) {
	#horizontal line
	x1 = min(x, A[1])
	x2 = max(x, A[1])
	for(i=x1; i<=x2; i++){
	    Path[i, y] = 1
	    Pathx[i] = Pathx[i] " " y
	    Pathy[y] = Pathy[y] " " i
	    if(A[1] > x){
		RightPath[i, y] = 1
		direction = "1,0"
	    } else if(A[1] < x){
		LeftPath[i, y] = 1
		direction = "-1,0"
	    }
	}
    } else {
	print("impossible error 01 " NR " " x " " y)
	exit
    }
    if(old_direction){
	if(concave(old_direction, direction)){
	    #print("is concave " A[1], A[2], old_direction, direction)
	    print("is concave " oldA1, oldA2, old_direction, direction)
	    #Left[A[1],A[2]] = 1
	} else {
	    #print("is convex " A[1], A[2], old_direction, direction)
	    print("is convex " oldA1, oldA2, old_direction, direction)
	    #Right[A[1],A[2]] = 1
	    Right[oldA1,oldA2] = 1
	    #Rightx[A[1]] = Rightx[A[1]] " " A[2]
	    Rightx[oldA1] = Rightx[oldA1] " " oldA2
	    #Righty[A[2]] = Rightx[A[2]] " " A[1]
	    Righty[oldA2] = Rightx[oldA2] " " oldA1
	}
    }
}
{
    print("load x y " A[1] " " A[2])
    x = A[1]
    y = A[2]
}

END{

    #test_solution(47602, 97984, 1831, 54902)


    #print("path: " ((3658, 50020) in Path) " right: " ((3658,50020) in RightPath) " up: " ((3658,50020) in UpPath) " left: " ((3658,50020) in LeftPath))
    #print(no_path_inside_rectangle(21, 268))
    #exit

    max_size = 0
    boxes_file = "boxes.txt"
    system("rm " boxes_file)
    for(i=1; i<=( NR-1); i++){
	print("i: "  i "/" NR)
	for(j=i+1; j<=(NR); j++){
	    size = (abs(Data[i, 1] - Data[j, 1]) + 1) * (abs(Data[i, 2] - Data[j, 2]) + 1)
	    #print("i: " i " j: " j "/" NR " size: " size)
	    print(size " " i " " j) >> boxes_file
	}
    }
    sorted_file = "sorted_boxes.txt"
    system("cat "boxes_file" | sort -n -r > "sorted_file)
    tries = 0
    while(getline line < sorted_file){
	tries += 1
	print("try " tries)
	split(line, A, " ")
	size = A[1]
	i = A[2]
	j = A[3]
	if(!(ARGV[1] == "input") || (tries > 27000)){
	    #if(!(Data[i,2] == 62000)){
	    if(no_path_inside_rectangle(i, j)){
	    
		print(Data[i, 1] "," Data[i, 2] " " Data[j, 1] "," Data[j, 2] " " size)
		print("result: " size)
		exit
	    }
	}
    }
}
function no_path_inside_rectangle(i, j,       x1,x2,y1,y2,a,b){
    x1 = min(Data[i, 1], Data[j, 1])
    x2 = max(Data[i, 1], Data[j, 1])
    y1 = min(Data[i, 2], Data[j, 2])
    y2 = max(Data[i, 2], Data[j, 2])
    print("rectangle  " Data[i,1] ","Data[i,2]" "Data[j,1]","Data[j,2])
    #print("rectangle2 " x1 ","y1" "x2","y2)
    #path on top of rectangle should be path right
    M = split(Righty[y1], A, " ")
    #no convex corners
    for(a=1; a<=M; a++){
	if((A[a] >= (x1+1)) && ((A[a]<=(x2-1)))){
	    print("no convex " a)
	    return(0)
	}
    }
    M = split(Pathy[y1], A, " ")
    for(a=1; a<=M; a++){
	if((A[a] >= (x1+1)) && ((A[a] <=(x2-1)))){
	#if((A[a] >= (x1)) && ((A[a] <=(x2)))){
	    if(!((A[a], y1) in RightPath)){
		print("top path should be path right ")
		return(0)
	    }
	}
    }

    M = split(Righty[y2], A, " ")
    #no convex corners
    for(a=1; a<=M; a++){
	if((A[a] >= (x1+1)) && ((A[a]<=(x2-1)))){
	    print("no convex " a)
	    return(0)
	}
    }
    M = split(Pathy[y2], A, " ")
    for(a=1; a<=M; a++){
	if((A[a] >= (x1+1)) && ((A[a] <=(x2-1)))){
	#if((A[a] >= (x1)) && ((A[a] <=(x2)))){
	    if(!((A[a], y2) in LeftPath)){
	    print("bottom should be path left " )
	    return(0)
	    }
	}
    }

    #for(a=(x1+1); a<=(x2-1); a++){
#	if((a, y2) in Right){#no convex corners
#	    print("no convex " a " " y2)
#	    return(0)
#	}
#	if(((a, y2) in Path) &&(!((a, y2) in LeftPath))){
#	    print("bottom should be path left " a " " y2)
#	    return(0)
#	}
#    }
    #left side of rectangle should be up path

    M = split(Rightx[x1], A, " ")
    #no convex corners
    for(a=1; a<=M; a++){
	if((A[a] >= (y1+1)) && ((A[a]<=(y2-1)))){
	    print("no convex " a )
	    return(0)
	}
    }
    M = split(Pathx[x1], A, " ")
    #print("pathx[" x1"] = " Pathx[x1])
    for(a=1; a<=M; a++){
	if((A[a] >= (y1+1)) && ((A[a] <=(y2-1)))){
	#if((A[a] >= (y1)) && ((A[a] <=(y2)))){
	    if(!((x1, A[a]) in UpPath)){
	    print("left should be path up ")
	    return(0)
	    }
	}
    }

    M = split(Rightx[x2], A, " ")
    #no convex
    for(a=1; a<=M; a++){
	if((A[a] >= (y1+1)) && ((A[a]<=(y2-1)))){
	    print("no convex " a )
	    return(0)
	}
    }
    M = split(Pathx[x2], A, " ")
    for(a=1; a<=M; a++){
	if((A[a] >= (y1+1)) && ((A[a] <=(y2-1)))){
	#if((A[a] >= (y1)) && ((A[a] <=(y2)))){
	    if(!((x2, A[a]) in DownPath)){
	    print("right should be path down ")
	    return(0)
	    }
	}
    }


	    
#    for(b=(y1+1); b<=(y2-1); b++){
#	if((x2, b) in Right){#no convex corners
#	    print("no convex " x2 " " b)
#	    return(0)
#	}
#	if(((x2, b) in Path) && (!((x2, b) in DownPath))){
#	    print("rigth should be path down " a " " y2)
#	    return(0)
#	}
#    }
    return(1)
}
function abs(a){
    if(a < 0){ return(-a)}
    return(a)
}
function max(a, b){
    if(a > b){return(a)}
    return(b)
}
function min(a, b){
    if(a < b){return(a)}
    return(b)
}

function concave(d1, d2){
    if((d1 == "1,0") && (d2 == "0,-1")){
        return(1)
    }
    if((d1 == "0,-1") && (d2 == "-1,0")){
        return(1)
    }
    if((d1 == "-1,0") && (d2 == "0,1")){
        return(1)
    }
    if((d1 == "0,1") && (d2 == "1,0")){
        return(1)
    }

    if((d1 == "1,0") && (d2 == "0,1")){
        return(0)
    }
    if((d1 == "0,-1") && (d2 == "1,0")){
        return(0)
    }
    if((d1 == "-1,0") && (d2 == "0,-1")){
        return(0)
    }
    if((d1 == "0,1") && (d2 == "-1,0")){
        return(0)
    }
    print("impossible error in concave " d1  " " d2)
}
