BEGIN {
    thing_regex = "(file [0-9]+ [0-9] [0-9]+)|(space [0-9] [0-9]+)"
}
{
    s = $0
    disk = ""
    step = "first"
    file_id = 0
    starting_location = 0
    while(match(s, /[0-9]/)){
        many = substr(s, RSTART, 1)
        if(step == "first"){
            disk = "file 0 " many " " starting_location
            step = "space"
        } else if(step == "file"){
            file_id += 1
            disk = disk "; file " file_id " " many " " starting_location
            step = "space"
        } else if(step == "space"){
            disk = disk "; space " many " " starting_location
            step = "file"
        }
        starting_location += many
        sub(/[0-9]/, "", s)
    }
}
function remove_id(file_id, disk,       many, start){
    reg = "file " file_id " [0-9] [0-9]+"
    if(match(disk, reg)){
        #print("remove id")
        #print(substr(disk, RSTART, RLENGTH))
        rs = RSTART
        rl = RLENGTH
        element = substr(disk, rs, rl)
        match(element, /[0-9] [0-9]+$/)
        ele_end = substr(element, RSTART, RLENGTH)
        many = substr(ele_end, 1, 1)
        start = substr(ele_end, 3, length(ele_end))
        disk = substr(disk, 1, rs-1) "; space " many " " start "; " substr(disk, rs+rl+1, length(disk))
    }
    return(disk)
}

function reverse(d, r,       s, x){
    s = d
    x = ""
    while(match(s, thing_regex)){
        x = substr(s, RSTART, RLENGTH) "; " x
        sub(thing_regex, "", s)
    }
    return(x)
}
function try_insert_earlier(s, disk){
    print("new try_insert_earlier " s)
    match(s, /[0-9]+/)
    file_id = substr(s, RSTART, RLENGTH)
    s = substr(s, RSTART+RLENGTH, length(s))
    match(s, /[0-9]/)
    many = substr(s, RSTART, RLENGTH)
    s = substr(s, RSTART+RLENGTH, length(s))
    match(s, /[0-9]+/)
    starting_location = substr(s, RSTART, RLENGTH)
    disk_pointer = 0
    while(match(substr(disk, disk_pointer, length(disk)), thing_regex)){
        #print("try insert earlier " disk_pointer)
        prev_pointer = disk_pointer
        disk_pointer = RSTART+RLENGTH+disk_pointer
        s = substr(disk, prev_pointer + RSTART-1, RLENGTH)
        match(s, /[a-z]+/)
        #print(s)
        #print(substr(s, RSTART, RLENGTH))
        if(substr(s, RSTART, RLENGTH) == "space"){
            print("found a space")
            match(s, /[0-9]/)
            many_space = substr(s, RSTART, RLENGTH)
            s = substr(s, RSTART+RLENGTH, length(s))
            match(s, /[0-9]+/)
            starting_space = substr(s, RSTART, RLENGTH)
            if(starting_space+0 > starting_location+0){
                print("earlier than start " starting_location  " " starting_space)
                return(disk)
            }
            if(many_space+0 >= many+0){
                extra_space = ""
                if(many_space > many){
                    extra_space = "; space " (many_space - many) " " (starting_space + many)  
                }
                disk = remove_id(file_id, disk)
                disk = substr(disk, 1, prev_pointer) "; file " file_id " " many " " starting_space extra_space "; " substr(disk, disk_pointer)
                print("updated disk")
                return(disk)
            }
        }
    }
    return(disk)
}
function compact(reverse_disk, disk,      s){
    while(match(reverse_disk, thing_regex)){
        print("compact")
        s = substr(reverse_disk, RSTART, RLENGTH)
        match(s, /[a-z]+/)
        if(substr(s, RSTART, RLENGTH) == "file"){
            disk = try_insert_earlier(s, disk)
        }
        sub(thing_regex, "", reverse_disk)
    }
    return(disk)
}
function decode_disk(disk,      s, r, type){
    r = ""
    while(match(disk, thing_regex)){
        s = substr(disk, RSTART, RLENGTH)
        match(s, /[a-z]+/)
        type = substr(s, RSTART, RLENGTH),
        if(type == "file"){
            1
        } else if(type == "space"){
            2
        } else {
            print("decode failure")
        }
    }
}

END {
    print("END")
    reverse_disk = reverse(disk, "")
#    print(disk)
#    print(reverse_disk)
    compacted_disk = compact(reverse_disk, disk)
    file = decode_disk(compacted_disk)
    print(file)
}
