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
(NR > 1){
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
	if(!(concave(old_direction, direction))){
	    Right[oldA1,oldA2] = 1
	    Rightx[oldA1] = Rightx[oldA1] " " oldA2
	    Righty[oldA2] = Rightx[oldA2] " " oldA1
	}
    }
}
{
    print("load " A[1] " " A[2])
    x = A[1]
    y = A[2]
}
END{
    max_size = 0
    boxes_file = "boxes.txt"
    system("rm " boxes_file)
    for(i=1; i<=( NR-1); i++){
	print("i: "  i "/" NR)
	for(j=i+1; j<=(NR); j++){
	    size = (abs(Data[i, 1] - Data[j, 1]) + 1) * (abs(Data[i, 2] - Data[j, 2]) + 1)
	    print(size " " i " " j) >> boxes_file
	}
    }
    sorted_file = "sorted_boxes.txt"
    system("cat "boxes_file" | sort -n -r > "sorted_file)
    tries = 0
    while(getline line < sorted_file){
	tries += 1
	split(line, A, " ")
	size = A[1]
	i = A[2]
	j = A[3]
	print("try " tries " " i " " j)
	if(no_path_inside_rectangle(i, j)){
	    print(Data[i, 1] "," Data[i, 2] " " Data[j, 1] "," Data[j, 2] " " size)
	    print("result: " size)
	    exit
	}
    }
}
function no_path_inside_helper(x1, x2, y1, Path, Rights, Paths){
    M = split(Rights[y1], A, " ")
    for(a=1; a<=M; a++)
	if((A[a] >= (x1+1)) && ((A[a]<=(x2-1))))
	    return(1)
    M = split(Paths[y1], A, " ")
    for(a=1; a<=M; a++)
	if((A[a] >= (x1+1)) && ((A[a] <=(x2-1))))
	    if(!((A[a], y1) in Path))
		return(1)
    return(0)
}
function no_path_inside_rectangle(i, j,       x1,x2,y1,y2,a,b){
    x1 = min(Data[i, 1], Data[j, 1])
    x2 = max(Data[i, 1], Data[j, 1])
    y1 = min(Data[i, 2], Data[j, 2])
    y2 = max(Data[i, 2], Data[j, 2])
    print("rectangle  " Data[i,1] ","Data[i,2]" "Data[j,1]","Data[j,2])
    if(no_path_inside_helper(x1, x2, y1, RightPath, Righty, Pathy))
	return(0)
    if(no_path_inside_helper(x1, x2, y2, LeftPath, Righty, Pathy))
	return(0)
    if(no_path_inside_helper(y1, y2, x1, UpPath, Rightx, Pathx))
	return(0)
    if(no_path_inside_helper(y1, y2, x2, DownPath, Rightx, Pathx))
	return(0)
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
    if((d1 == "1,0") && (d2 == "0,-1"))
        return(1)
    if((d1 == "0,-1") && (d2 == "-1,0"))
        return(1)
    if((d1 == "-1,0") && (d2 == "0,1"))
        return(1)
    if((d1 == "0,1") && (d2 == "1,0"))
        return(1)

    if((d1 == "1,0") && (d2 == "0,1"))
        return(0)
    if((d1 == "0,-1") && (d2 == "1,0"))
        return(0)
    if((d1 == "-1,0") && (d2 == "0,-1"))
        return(0)
    if((d1 == "0,1") && (d2 == "-1,0"))
        return(0)
    print("impossible error in concave " d1  " " d2)
}
