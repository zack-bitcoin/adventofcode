
# a d d c b b a i j j i a d e f g h h g f e e d c c

# d, b, j, h, e, c


#has flow: jt 9, ph 20, ir 13, sv 16, uv 19, ez 8, ke 21, oy 11, nn 23, fu 14, pt 18, if 25, to 3, fc 25, qg 5

#time acc flow path
#4 0 8 ,2-EZ-8
#7 24 30 ,2-EZ-8,2-FC-22
#11 144 49 ,2-EZ-8,2-FC-22,3-UV-19
#19 536 70 2-EZ-8,2-FC-22,3-UV-19,7-KE-21
#22 746 83 2-EZ-8,2-FC-22,3-UV-19,7-KE-21,2-IR-13
#25 995 103 2-EZ-8,2-FC-22,3-UV-19,7-KE-21,2-IR-13,2-PH-20
#32 1716 108 2-EZ-8,2-FC-22,3-UV-19,7-KE-21,2-IR-13,2-PH-20,6-QG-5
   

#1716 ,3-UV-19,3-FC-22,2-EZ-8,4-JT-9,2-KE-21,2-IR-13,2-PH-20,3-IF-25



BEGIN{
    time_limit = 30
    got_flow = "AA"
    max_flow = 137
    best_total_score = 1650
}
{
    Names[NR] = substr($0, 7, 2)
    name = Names[NR]
    match($5, /[0-9]+/)
    Rate[name] = substr($5, RSTART, RLENGTH)
    if(Rate[name] == 0){
        zero_rated = zero_rated","name
    } else {
        got_flow = got_flow","name
    }
    split($0, A, "valve(s)? ")
    Paths[name] = A[2]

}
END{
    M = split(got_flow, A, ",")
    print("precalc distances " got_flow)
    for(i=1; i<=M; i++){
        for(j=1; j<=M; j++){
            if(A[i] < A[j]){
                d = distance(A[i], A[j])
                DISTANCES[A[i],A[j]] = d
                DISTANCES[A[j],A[i]] = d
            } else if(A[i] == A[j]){
                DISTANCES[A[i],A[j]] = 0
            }
        }
    }
    print("precalc done")
    print(search("AA", 1, substr(zero_rated, 2), 0, 0, ""))
    print(max_flow)
    print("best path: " best_path)
    print(best_total_score)
}
function score_check(name, time, opened){
    for(i=time; i>=1; i--){
        hd = high_score[name, i, opened]
        if(hd){return (hd)}
    }
    return(-1)
}
function search(name, time, opened, flow, acc, path,        hs, M, X, result, A, i, N, RemainingNames, file, file2, name2, dist, RemainingNames2, result2){
    if((acc + ((time_limit-time+1)*max_flow)) < best_total_score){
        #prune because it is impossible to win with this path.
        return(0)
    }
    hs = score_check(name, time, opened)
    if((acc <= hs)){
        #prune because we have already confirmed that this position can be reached with a higher flowrate.
        return(0)
    }
    high_score[name, time, opened] = acc
    M = split(opened, X, ",")
    if(M == NR){
        result = acc + (flow*(time_limit - time+1))
        if(result > best_total_score){
            best_total_score = result
            best_path = path
        }
        return(result)
    }
    result = 0
    file = "to_sort.txt"
    system("rm to_sort.txt")
    RemainingNames = ""
    for(i=1; i<=NR; i++){
        name2 = Names[i]
        if(!(already_opened(name2, opened))){
            dist = (DISTANCES[name, name2])
            RemainingNames = RemainingNames dist","name2"\n"
        }
    }
    printf(RemainingNames) > file
    close(file)
    system("sort -n to_sort.txt > sorted.txt")
    file2 = "sorted.txt"
    RemainingNames2 = ""
    while(getline line < file2){
        split(line, A, ",")
        RemainingNames2 = RemainingNames2 "," A[2]
    }
    close(file2)
    M = split(RemainingNames2, A, ",")
    for(i=2; i<=M; i++){
        name2 = A[i]
        dist = DISTANCES[name, name2]
        if(time+dist+1 < 31){
            result2 = search(name2, time+dist+1, insert_opened(name2, opened), flow+(Rate[name2]), acc + (flow*(dist+1)), (path","dist"-"name2"-"Rate[name2]))
        } else {
            result2 = acc + (flow*(time_limit - time+1))
            if(result2 > best_total_score){
                best_path = path
                best_total_score = result
                max_flow = flow
            }
        }
        result = max(result, result2)
    }
    return(result)
}
function distance(l, loc){
    return(distance2(l, loc, 0))
}
function distance2(l, loc, d){
    if(is_in(loc, l)){
        return(d)
    } else {
        return(distance2(expand(l), loc, d+1))
    }
}
function is_in(a, l){
    return(already_opened(a, l))
}
function expand(l,      M, s, A, i, paths, B, N, j){
    s = ""
    M = split(l, A, ",")
    for(i=1; i<=M; i++){
        paths = Paths[A[i]]
        N = split(paths, B, ", ")
        for(j=1; j<=N; j++){
            if(!(is_in(B[j], s))){
                s = s "," B[j]
            }
        }
    }
    return(substr(s, 2))
}
function already_opened(name, opened,     M, A, i){
    M = split(opened, A, ",")
    for(i=1; i<=M; i++){
        if(A[i] == name){
            return(1)
        }
    }
    return(0)
}
function insert_opened(name, opened,     M, A, i, s){
    if(!(name)){return(opened)}
    M = split(opened, A, ",")
    s = ""
    for(i = 1; i<=M; i++){
        if(name > A[i]){
            s = s "," A[i]
        } else {
            return(substr((s "," name opened_rest(i, M, A)), 2))
        }
    }
    s = s","name
    return(substr(s, 2))
}
function opened_rest(i, M, A, s){
    s = ""
    for(;i<=M;i++){
        s = s "," A[i]
    }
    return(s)
}
function max(a, b){
    if(!(a) && b) {return(b)}
    if(!(b) && a) {return(a)}
    if((a+0)< (b+0)){ return(b)}
    else {return (a)}
}
