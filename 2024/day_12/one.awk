#break into regions.
#for each region, calculate area and perimeter.
# sum += (area * perimeter)
function lookup(row, col){
    if((row < 1) || (row > NR) || (col < 1) || (col > cols)){
        return(".")
    }
    return(substr(Lines[row], col, 1))
}
function diff(a, b){
    if(a > b){
        return(a - b)
    } else {
        return(b - a)
    }
}
function count_kisses(row, col, A,     i, kisses){
    kisses = 0
    for(i in A){
        split(i, Q, SUBSEP)
        if((diff(Q[1], row) + diff(Q[2], col)) == 1){
            kisses += 1
        }
    }
    return(kisses)
}
function paintbucket(value, row, col, pts,     up, left, right, down){
    if(!((row, col) in pts)){
        pts[row, col] = 1
        up = lookup(row-1, col)
        left = lookup(row, col-1)
        right = lookup(row, col+1)
        down = lookup(row+1, col)
        if(up == value){
            paintbucket(value, row-1, col, pts)
        }
        if(left == value){
            paintbucket(value, row, col-1, pts)
        }
        if(right == value){
            paintbucket(value, row, col+1, pts)
        }
        if(down == value){
            paintbucket(value, row+1, col, pts)
        }
    }
}

function add_region(row, col,       pts, v, kisses, m, area, perimeter){
    v = lookup(row, col)
    paintbucket(v, row, col, pts)
    kisses = 0
    m=0
    for(R2 in pts){
        split(R2, R3, SUBSEP)
        R = R3[1]
        C = R3[2]
        m+=1
        Filled[R, C] = 1
        kisses += count_kisses(R, C, pts)
    }
    area = m
    perimeter = 4*area - kisses
    return(area * perimeter)
    
}

function get_regions(many_rows, many_cols,     result){
    for(row = 1; row<=many_rows; row++){
        for(col=1; col<=many_cols; col++){
            if(!((row, col) in Filled)){
                sum += add_region(row, col)
            }
        }
    }
    print(sum)
}

{
    Lines[NR] = $0
}

END {
    cols = length(Lines[1])
    regions = get_regions(NR, cols)
}
