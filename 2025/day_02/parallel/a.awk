BEGIN{
    sum = 0
}
{
    M = split($0, A, ",")
    system("rm result.txt")
    for(i=1; i<=M; i++){
        split(A[i], B, "-")
        start = B[1]
        end = B[2]
        #scan(start, end)
        system("awk -f scan.awk " start " " end" &")
    }
    system("sleep 1")
    sum = 0
    while(getline line < "result.txt"){
        sum += line
    }
}
END{
    print("result " sum)
}
