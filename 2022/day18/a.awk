#5:51
{
    split($0, A, ",")
    x = A[1]
    y = A[2]
    z = A[3]
    DB[$0] = 1
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
}

function to_key(x, y, z){
    return(x "," y "," z)
}
