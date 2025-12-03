BEGIN{
    start = ARGV[1]
    end = ARGV[2]
    r = scan(start, end)
    print("scan " start " " end " resulted in " r)
    F = "result.txt"
    print(r) >> F
    #close(F)
}
function scan(start, end,       i, sum){
    sum = 0
    for(i=start; i<= end; i++){
        if(is_invalid(i)){
            sum+= i
        }
    }
    return(sum)
}
function is_invalid(n){
    n = n ""
    l = length(n)
    l2 = int(l/2)
    a = substr(n, 1, l2)
    b = substr(n, l2+1)
    return(b == a)
}
