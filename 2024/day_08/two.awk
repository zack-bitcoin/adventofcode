function add_antinodes(row, col, row2, col2, rdiff, cdiff){
    trow = row2
    tcol = col2
    while((trow <= NR) && (tcol <= len) && (trow > 0) && (tcol > 0)){
        Antinodes[trow, tcol] = 1
        trow += rdiff
        tcol += cdiff
    }
    trow = row
    tcol = col
    while((trow <= NR) && (tcol <= len) && (trow > 0) && (tcol > 0)){
        Antinodes[trow, tcol] = 1
        trow -= rdiff
        tcol -= cdiff
    }
}
{
    len = length($0)
    for(i=1; i<=len; i++){
        n = substr($0, i, 1)
        if(!(n == ".")){
            Antenna[NR, i] = n
        }
    }
}
END{
    for(x in Antenna){
        split(x, x2, SUBSEP)
        row = x2[1]
        col = x2[2]
        for(y in Antenna){
            split(y, y2, SUBSEP)
            row2 = y2[1]
            col2 = y2[2]
            if((row == row2) && (col == col2)){
                #antenna don't create antinodes with themselves.
            } else if(Antenna[row, col] == Antenna[row2, col2]) {
                #antenna are the same letter, so they potentially create antinodes together.
                rdiff = row2 - row
                cdiff = col2 - col
                add_antinodes(row, col, row2, col2, rdiff, cdiff)
            }
        }
    }
    for(x in Antinodes){
        sum+=1
    }
    print(sum)
}
