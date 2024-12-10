function compact_memory2(p1, p2){
    print("compact memory " p1 " " p2)
    #print("compact memory2 " p1 " " p2 " " Memory[p2])
    if(p1 >= p2){
        return(0)
    }
    if(Memory[p2] == "."){
        return(compact_memory2(p1, p2-1))
    }
    #find earliest slot that can fit the next file
    f_size = file_size(p2, 0, Memory[p2])
    #print("f size " f_size)
    p3 = space_that_encloses(f_size, p1, p2)
    #print("p3 " p3)
    #print("p3 from space that encloses " p3)
    if(p3 == "none"){
        return(compact_memory2(1, p2-f_size))
    }
    shift_size = shift_file(p2, p3, Memory[p2])
    str = ""
    for(i=0; i<slot; i++){
        #str = str Memory[i]
    }
    #print(str)
    #return(compact_memory2(p1+shift_size, p2-f_size))
    return(compact_memory2(p1, p2-f_size))
}
function shift_file(p3, p1, val){
    if(p3 < p1){
        return(0)
    }
    #print("shift_file " p3 " " p1 " " val)
    if(!(Memory[p3] == val)){
        #print("shift done")
        return(0)
    }
    if(!(Memory[p1] == ".")){
        print("shift file error. memory overwritten")
        return(0)
    }
    Memory[p1] = Memory[p3]
    Memory[p3] = "."
    return(1+shift_file(p3-1, p1+1, val))
}
function file_that_fits(size, p2, p1){
    #print("file that fits")
    if(p2 <= p1){
        return("none")
    }
    val = Memory[p2]
    if(val == "."){
        return(file_that_fits(size, p2-1, p1))
    }
    s = file_size(p2, 0, val)
    #print("file that fits " p2 " " s)
    if(s <= size){
        return(p2)
    } else {
        return(file_that_fits(size, p2-s, p1))
    }
}
function space_that_encloses(size, p1, p2){
    #print("space that encoses " size " " p1 " " p2 " " Memory[p1])
    if(p1 >= p2){
        #print("space that encloses return none")
        return("none")
    }
    if(Memory[p1] != "."){
        return(space_that_encloses(size, p1+1, p2))
    }
    s = space_size(p1, 0)
    if(s >= size){
        #print("space that encloses return p1 " p1)
        return(p1)
    } else {
        return(space_that_encloses(size, p1+s, p2))
    }
}
function file_size(p, n, val){
    #print("file size")
    if(p < 0){
        return(n)
    }
    if (!(Memory[p] == val)){
        return(n)
    } else {
        return(file_size(p-1, n+1, val))
    }
}
function space_size(p, n){
    #print("space size")
    if (Memory[p] == "."){
        return(space_size(p+1, n+1))
    } else {
        return(n)
    }
}

{
    s = $0
    step = "file"
    slot = 0
    id = 0
    while(match(s, /[0-9]/)){
        d = substr(s, 1, 1)
        if(step == "file"){
          for(i=0; i < d; i++){
              #print("write to " slot " value " id)
              Memory[slot] = id
              slot += 1
          }
          step = "space"
          id += 1
        } else if (step == "space"){
          for(i=0; i<d; i++){
              Memory[slot] = "."
              slot += 1
          }
          step = "file"
        }
        sub(/[0-9]/, "", s)
    }
}
END {
    s = ""
    for(i=0; i<slot; i++){
        s = s Memory[i]
    }
    #print(s)
    compact_memory2(0, slot-1)
    s = ""
    for(i=0; i<slot; i++){
        s = s Memory[i]
    }
    #print(s)
    print("doing sum")
    for(i=0; i<slot; i++){
        x = Memory[i]
        if(!(x == ".")){
            sum += (i*x)
        }
    }
    print(s)
    print("result: " sum)
}

#too high 6276643946514
#too high 6272188436461
