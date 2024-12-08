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
    #print input to verify that the antenna spots are loaded correctly.
    for(j=1; j<=NR; j++){
        s = ""
        for(i=1; i<=len; i++){
            if((j, i) in Antenna){
                s = s Antenna[j, i]
            } else {
                s = s "."
            }
        }
        #print(s)
    }

    #calculate the antinodes
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
                row3 = row2 + rdiff
                col3 = col2 + cdiff
                if((row3 > 0) && (row3 <= NR) &&
                   (col3 > 0) && (col3 <= len)){
                    Antinodes[row3, col3] = 1
                }
            }
        }
    }
    for(x in Antinodes){
        sum+=1
    }
    print(sum)
}
