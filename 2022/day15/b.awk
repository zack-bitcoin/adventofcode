BEGIN{
    #scan_range = 20
    scan_range = 4000000
}
{
    sx = substr($3, 3, length($3)-3)
    sy = substr($4, 3, length($4)-3)
    bx = substr($9, 3, length($9)-3)
    by = substr($10, 3, length($10)-2)
    dist = distance(sx, sy, bx, by)
    Sx[NR] = sx
    Sy[NR] = sy
    Dist[NR] = dist
    #points =";"(sx+dist)","sy";"sx","(sy+dist)";"(sx-dist)","sy";"sx","(sy-dist)
    #points ="sx","(sy+dist)";"sx","(sy-dist)
    #lines:  y(x) = sy+dist - sx + y*x, y(x) = sy+dist + sx - yx, y(x) = sy-dist - sx + y*x, y(x) = sy-dist + sx - yx
    # top-left, top-right, bottom-right, bottom-left
    Y[1][NR] = sy-sx+dist#top left
    Y[2][NR] = sy+sx+dist#top right
    Y[3][NR] = sy-sx-dist# bottom right
    Y[4][NR] = sy+sx-dist#bottm left
    #print(y_intersepts)
    #print(path)
    #paths = paths "_" path

    #30,-9,31,-8
}
#found rising pair
#-90630 -90628
#result is probably on this line y(x) = x*y - 90639
    

END{
    for(i=1; i<=NR; i++){#first rising
        y1 = Y[1][i]
        for(j=1; j<=NR; j++){
            y3 = Y[3][j]
            if(y3 == (y1+2)){#found rising pair")
                for(k=1; k<=NR; k++){
                    y2 = Y[2][k]
                    for(m=1; m<=NR; m++){
                        y4 = Y[4][m]
                        if(y2 == (y4 - 2)){#found a falling pair
                            potentials += 1
                            low = int((y1+y3)/2)
                            high = int((y2+y4)/2)
                            x = int((high - low)/2)
                            y = int((low + high)/2)
                            if((x >= 0)&&(x <= scan_range)){
                                if((y >= 0)&&(y <= scan_range)){
                                    print(4000000*x + y)
                                }
                            }
                        }
                    }
                }
            }
        }
    }

}

function diamonds_to_paths(s){
    M = split(s, A, ";")
    for(i=2; i<=M; i++){
        N = split(A[i], B, ",")
        x = B[1]
        y = B[2]
        dist = B[3]
    }
}

function compress_ranges(ranges,     M, A, B, start, end, can_combine){
    #print("compress_ranges " ranges)
    if(ranges == ""){
        return(0)
    }
    M = split(ranges, A, ";")
    split(A[2], B, ",")
    start = B[1]+0
    end = B[2]+0
    rest = substr(ranges, length(A[2])+2)
    can_combine = combine(start, end, rest)
    if(can_combine == ranges){
        can_combine = 0
    }
    if(can_combine == 0){
        #print(start, end, "was not combinable with", rest)
        #print(A[2])
        return(end - start + 1 + compress_ranges(rest))
    } else {
        return(compress_ranges(can_combine))
    }
}
function combine(start, end, ranges){
    M = split(ranges, A, ";")
    s = ""
    done = 0
    for(i=2; i<=M; i++){
        split(A[i], B, ",")
        start2 = B[1]+0
        end2 = B[2]+0
        #print("start2 end2 " start, end, start2, end2)
        if(((end < start2)) ||
           ((start > end2)) ||
            done){
            #can't combine
            s = s ";"start2","end2
        } else {
            newstart = min(start, start2)
            newend = max(end, end2)
            #print("combined "start, end " and " start2, end2 " into " newstart, newend)
            s = s ";"newstart","newend
            done = 1
        }
    }
    if(done){return(s)}
    return(0)#didn't find a way to combine
}
function min(a, b){
    if(a < b){return(a)}
    return(b)
}
function max(a, b){
    if(a > b){return(a)}
    return(b)
}
function abs(x) {
    if(x < 0){ return(-x)}
    return(x)
}
function distance(a, b, c, d){
    return(abs(a - c) + abs(b - d))
}
function not_here(x, y, Mappings,     M, A){
    M = split(Mappings, A, ";")

    for(i = 2; i<= M; i++){
        split(A[i], B, ",")
        sx = B[1]
        sy = B[2]
        dist1 = B[3]
        dist2 = distance(x, y, sx, sy)
        if(dist2 <= dist){
            return(1)
        }
    }
    return(0)
}
