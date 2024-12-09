function compact_memory(p1, p2){
    if(p1 >= p2){
        return(0)
    }
    if(Memory[p2] == "."){
        return(compact_memory(p1, p2-1))
    }
    if(Memory[p1] == "."){
        Memory[p1] = Memory[p2]
        Memory[p2] = "."
        return(compact_memory(p1+1, p2-1))
    }
    return(compact_memory(p1+1, p2))
}

{
    print("line")
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
    compact_memory(0, slot-1)
    i = 0
    while(!(x == ".")){
        x = Memory[i]
        sum += (i*x)
        i++
    }
    s = ""
    for(i=0; i<slot; i++){
        s = s Memory[i]
    }
    print(s)
    print(sum)
}
