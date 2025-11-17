#around 2 hours.

BEGIN{
    row = 2000000
}

{
    sx = substr($3, 3, length($3)-3)
    sy = substr($4, 3, length($4)-3)
    bx = substr($9, 3, length($9)-3)
    by = substr($10, 3, length($10)-2)
    dist = distance(sx, sy, bx, by)

    row_dist = abs(sy - row)
    radius = dist - row_dist
    if(radius > -1){
        start = sx - radius
        end = sx + radius
        ranges = ranges ";"start","end
        #print(sx, sy, bx, by, dist, radius, start, end)
    } else {
        print("no overlap " sx, sy, bx, by, dist, radius)
    }
    
    Beacons[bx][by] = 1
    #print("beacon " bx, by)
    Sensors[sx][sy] = 1

    #Mappings = Mappings ";" sx ","sy","distance(sx, bx, sy, by)
}

END{
print(ranges)
ranges2 = compress_ranges(ranges)
row_beacons = 0
for(x in Beacons){
    print("scanning beacons " x)
    if(Beacons[x][row] == 1){
        row_beacons += 1
    }
}
print("row beacons " row_beacons)
print(ranges2 - row_beacons)
}

function compress_ranges(ranges,     M, A, B, start, end, can_combine){
    print("compress_ranges " ranges)
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
        print(start, end, "was not combinable with", rest)
        print(A[2])
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
            print("combined "start, end " and " start2, end2 " into " newstart, newend)
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
