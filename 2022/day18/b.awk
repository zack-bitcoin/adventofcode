#1:14:40

BEGIN{
    maxx = -1000000
    maxy = -1000000
    maxz = -1000000
    minx = 10000000
    miny = 10000000
    minz = 10000000
}
{
    split($0, A, ",")
    x = A[1]
    y = A[2]
    z = A[3]
    maxx = max(x, maxx)
    maxy = max(y, maxy)
    maxz = max(z, maxz)
    minx = min(x, minx)
    miny = min(y, miny)
    minz = min(z, minz)
    DB[$0] = 1
    Steamed[$0] = 0
}

function min(a, b){
    return((a < b) ? a : b)
}
function max(a, b){
    return((a > b) ? a : b)
}

END {
   for(key in DB){
      split(key, A, ",")
    x = A[1]
    y = A[2]
    z = A[3]
    if(!(to_key(x, y, z+1) in DB)){
        surface += 1
    }
    if(!(to_key(x, y, z-1) in DB)){
        surface += 1
    }
    if(!(to_key(x+1, y, z) in DB)){
        surface += 1
    }
    if(!(to_key(x-1, y, z) in DB)){
        surface += 1
    }
    if(!(to_key(x, y+1, z) in DB)){
        surface += 1
    }
    if(!(to_key(x, y-1, z) in DB)){
        surface += 1
    }
   }
   print(surface)
   print("look for bubbles")
   for(x=minx; x<=maxx; x++){
       for(y=miny; y<=maxy; y++){
           for(z=minz; z<=maxz; z++){
               steamed(x, y, z)
           }
       }
   }
   print("start sanity check\n")
   for(x=minx; x<=maxx; x++){
       for(y=miny; y<=maxy; y++){
           for(z=minz; z<=maxz; z++){
               key = to_key(x, y, z)
               if((key in interior) && (key in Steamed)){
                   print("impossible error " key)
                   print("bounds " minx, maxx, miny, maxy, minz, maxz)
                   error()
               }
           }
       }
   }
   print("end sanity check\n")
   for(key in interior){
       #print("key in interioer " key)
      split(key, A, ",")
      x = A[1]
      y = A[2]
      z = A[3]
    if(!(to_key(x, y, z+1) in interior)){
        surface2 += 1
    }
    if(!(to_key(x, y, z-1) in interior)){
        surface2 += 1
    }
    if(!(to_key(x+1, y, z) in interior)){
        surface2 += 1
    }
    if(!(to_key(x-1, y, z) in interior)){
        surface2 += 1
    }
    if(!(to_key(x, y+1, z) in interior)){
        surface2 += 1
    }
    if(!(to_key(x, y-1, z) in interior)){
        surface2 += 1
    }
   }
   print("surface2 " surface2)
   print("diff " surface - surface2)
}

function steamed(x, y, z,    key){
    key = to_key(x, y, z)
    if(key in Steamed){
        return(Steamed[key])
    }
    if(steamed_check(x, y, z)){ return(1) }
    else {
        return(steamed2(x, y, z, key))
    }
}
function steamed_check(x, y, z, key){
    #1 means it is steamed. 0 means we don't know yet.
    if(key in Steamed){
        return(Steamed[key])
    }
    if((x > maxx) || (x < minx) || (y > maxy) || (y < miny) || (z > maxz) || (z < minz)){
        Steamed[key] = 1
        return(1)
    }

}
function make_boarder(x, y, z){
    return((x+1)","y","z";"(x-1)","y","z";"x","(y+1)","z";"x","(y-1)","z";"x","y","(z+1)";"x","y","(z-1)";"x","y","z)
}
function expand_boarders(a,       M, A, s, i, mb, b){
    M = split(a, A, ";")
    s = a
    for(i=1; i<=M; i++){
        split(A[i], B, ",")
        mb = make_boarder(B[1], B[2], B[3])
        b = filter_boarders(mb)
        s = merge_boarders(b, s)
    }
    return(s)
}
function merge_boarders(a, b,     M, A, s, i){
    M = split(a, A, ";")
    s = b
    for(i=1; i<=M; i++){
        if(match(b, A[i])){
        } else {
            s = s ";" A[i]
        }
    }
    return(s)
}
function filter_boarders(a,       M, A, s, i){
    M = split(a, A, ";")
    s = ""
    for(i=1; i<=M; i++){
        if(A[i] in DB){
        } else {
            s = s ";"A[i]
        }
    }
    return(substr(s, 2))
}

function to_key(x, y, z){
    return(x "," y "," z)
}
function steamed2(x, y, z, key,      b1, b, B, A, B2, unused, i){
    #print("steamed2 " key)
    b2 = ""
    b = key
    while(1){
        b = expand_boarders(b)
        B = split(b, A, ";")
        #print("boarder size " B ", " b)
        B2 = split(b2, unused, ";")
        #print("B B2 " B ", " B2 ", " b ", " key)
        if((!(b2 == "")) &&(B == B2)){
    #if expand_boarders leaves it unchanged, then all elements are interior
            print("found a bubble " b, b2)
            for(i=1; i<=B; i++){
                split(A[i], C, ",")
                key = to_key(C[1], C[2], C[3])
                print("into interior " key)
                interior[key] = 1
            }
            return(0)
        }
        for(i=1; i<=B; i++){
            split(A[i], C, ",")
            key = to_key(C[1], C[2], C[3])
            if(steamed_check(C[1], C[2], C[3], key)){
    #if any element is out of bounds, then all elements are steamed.
                for(i=1; i<=B; i++){
                    split(A[i], C, ",")
                    key = to_key(C[1], C[2], C[3])
                    Steamed[key] = 1
                }
                return(0)
            }
            if(key in interior){
                #if any element is interior, then all elements are interior.
                for(i=1; i<=B; i++){
                    split(A[i], C, ",")
                    key = to_key(C[1], C[2], C[3])
                    interior[key] = 1
                }
                return(0)
            }
        }
        b2 = b
    }
}
