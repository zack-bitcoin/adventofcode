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
function remove_id(file_id, disk,       many, start, ele_end, element, rl, rs, reg){
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

function reverse(d,       r, m, s, i){
    m = split(d, s, ";")
    for(i=m; i>=0; i--){
        r = r ";" s[i]
    }
    return(r)
}
function try_insert_earlier_b(s, disk,        i, m, starting_location, many, file_id, many_space, extra_space, disk2){
    split(s, a, " ")
    file_id = a[2]
    many = a[3]
    starting_location = a[4]
    m = split(disk, d, ";")
    for(i=1; i<=m; i++){
        split(d[i], vals, " ")
        type = vals[1]
        if(type == "space"){
            many_space = vals[2]
            start_space = vals[3]
            if(start_space+0 > starting_location+0){
                return(disk)
            }
            if(many_space+0 >= many+0){
                extra_space = ""
                if(many_space+0 > many+0){
                    extra_space = "; space " (many_space - many) " " (start_space + many)
                }
                disk = remove_id(file_id, disk)
                print("try insert earlier b")
                print("file " file_id " " many " " start_space " " extra_space " ; ")
                d[i] = "file " file_id " " many " " start_space extra_space " ; "
                #disk = substr(disk, 1, prev_pointer) "; file " file_id " " many " " starting_space extra_space "; " substr(disk, disk_pointer)
                disk2 = ""
                for(j=1; j<=m; j++){
                    disk2 = disk2 ";" d[j] 
                }
                print(disk2)
                return(disk2)
            }
        }
    }
    return(disk)
}
function decode(disk,      r, a, b){
    r = ""
    m = split(disk, a, ";")
    for(i=0; i<m; i++){
        split(a[i], b, " ")
        type = b[1]
        if(type == "space"){
            many = b[2]
            for(j=1; j<=(many+0); j++){
                r = r "0"
            }
        } else if(type == "file"){
            many = b[3]
        }
    }
}
function try_insert_earlier(s, disk){
    #print("new try_insert_earlier " s)
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
            #print("found a space")
            match(s, /[0-9]/)
            many_space = substr(s, RSTART, RLENGTH)
            s = substr(s, RSTART+RLENGTH, length(s))
            match(s, /[0-9]+/)
            starting_space = substr(s, RSTART, RLENGTH)
            if(starting_space+0 > starting_location+0){
                #print("earlier than start " starting_location  " " starting_space)
                return(disk)
            }
            if(many_space+0 >= many+0){
                extra_space = ""
                if(many_space+0 > many+0){
                    extra_space = "; space " (many_space - many) " " (starting_space + many)  
                }
                disk = remove_id(file_id, disk)
                disk = substr(disk, 1, prev_pointer) "; file " file_id " " many " " starting_space extra_space "; " substr(disk, disk_pointer)
                #print("updated disk")
                return(disk)
            }
        }
    }
    return(disk)
}
function compact2(reverse_disk, disk,     rd, mrd, i, s){
    mrd = split(reverse_disk, rd, ";")
    for(i=1; i<= mrd; i++){
        s = rd[i]
        #print("compact " s)
        match(s, /[a-z]+/)
        if(substr(s, RSTART, RLENGTH) == "file"){
            disk = try_insert_earlier_b(s, disk)
        }
    }
    return(disk)
}


function compact(reverse_disk, disk,      s, n){
    n=0
    while(match(reverse_disk, thing_regex)){
        n++
        print("compact " n)
        s = substr(reverse_disk, RSTART, RLENGTH)
        match(s, /[a-z]+/)
        if(substr(s, RSTART, RLENGTH) == "file"){
            disk = try_insert_earlier(s, disk)
        }
        sub(thing_regex, "", reverse_disk)
    }
    return(disk)
}
function decode_disk(disk,      s, r, type, a, i){
    r = ""
    while(match(disk, thing_regex)){
        s = substr(disk, RSTART, RLENGTH)
        split(s, a, " ")
        type = a[1]
        if(type == "file"){
            many = a[3]
            id = a[2]
            for(i=1; i<=many; i++){
                r = r id
            }
        } else if(type == "space"){
            many = a[2]
            for(i=1; i<=many; i++){
                r = r "0"
            }
        } else {
            print("decode failure")
        }
        sub(thing_regex, "", disk)
    }
    return(r)
}
function sum_disk(disk,      s, r, type, location, sum, a, id, many, start, i){
    r = ""
    sum = 0
    while(match(disk, thing_regex)){
        #print(sum)
        s = substr(disk, RSTART, RLENGTH)
        split(s, a, " ")
        #match(s, /[a-z]+/)
        #type = substr(s, RSTART, RLENGTH)
        type = a[1]
        if(type == "file"){
            id = a[2]
            many = a[3]
            start = a[4]
            #print(id " " many " " start)
            for(i=start; i< start+many; i++){
                sum += (i*id)
            }
        } else if(type == "space"){
            many = a[2]
            start = a[4]
        } else {
            print("decode failure")
        }
        sub(thing_regex, "", disk)
    }
    return(sum)
}

END {
    print("reverse disk")
    reverse_disk = reverse(disk)
#    print(disk)
#    print(reverse_disk)
    print("compacting")
    compacted_disk = compact2(reverse_disk, disk)
    print("compacted. ")
    print(decode_disk(compacted_disk))
    print("compacted. now summing")
    file = sum_disk(compacted_disk)
    print(file)
}
