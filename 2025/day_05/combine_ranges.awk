{
    Starts[NR] = $1
    Ends[NR] = $2
}

END{
    print_result(1)
}

function print_result(line){
    if(line == NR){
        print(Starts[NR] " " Ends[NR])
    }
    if(line >= NR){
        return(0)
    }
    line2 = try_combine(Starts[line], Ends[line], line+1)
    print_result(line2)
}

function try_combine(start, end, line){
    if(line > NR){
        print(start " " end)
        return(line+1)
    }
    if(end >= Starts[line]){
        return(try_combine(min(start, Starts[line]), max(end, Ends[line]), line+1))
    } else {
        print(start " " end)
        return(line)
    }
}

function min(a, b){
    if(a < b){return(a)}
    return(b)
}
function max(a, b){
    if(a > b){return(a)}
    return(b)
}
