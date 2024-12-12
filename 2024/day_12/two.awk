#break into regions.
#for each region, calculate area and sides
# sum += (area * sides)
function lookup(row, col){
    if((row < 1) || (row > NR) || (col < 1) || (col > cols)){
        return(".")
    }
    return(substr(Lines[row], col, 1))
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

function add_region(row, col,       pts, v, kisses, m, area, perimeter, R2, R, C){
    v = lookup(row, col)
    paintbucket(v, row, col, pts)
    m=0
    for(R2 in pts){
        split(R2, R3, SUBSEP)
        R = R3[1]
        C = R3[2]
        m+=1
        Filled[R, C] = 1
    }
    area = m
    sides = calculate_sides(pts)
    #print("area: " m)
    return(area*sides)
}
function calculate_sides(pts,       row, col, pts2, borders, x, y, b,side, adjust, sum){
    #first calculate borders, which are the units that make up the perimeter.
    #print("get borders")
    for(x in pts){
        split(x, y, SUBSEP)
        row = y[1]
        col = y[2]
        if(borders[row-1,col,"down"] == 1){
            borders[row-1,col,"down"] = 0
        } else {
            borders[row,col,"up"]=1
        }
        if(1 == borders[row+1,col,"up"]){
            borders[row+1,col,"up"] = 0
        } else {
            borders[row,col,"down"]=1
        }
        if(1 == borders[row, col+1, "left"]){
            borders[row,col+1,"left"] = 0
        } else {
            borders[row,col,"right"] = 1
        }
        if(1 == borders[row, col-1, "right"]){
            borders[row,col-1,"right"] = 0
        } else {
            borders[row,col,"left"] = 1
        }
    }
    for(b in borders){
        if(borders[b] == 1){
            split(b, y, SUBSEP)
            row = y[1]
            col = y[2]
            side = y[3]
            #print("border: " row " " col " " side)
            adjust = 2
            if((side == "up")||(side == "down")){
                if(1 == borders[row, col+1, side]){
                    adjust -= 1
                }
                if(1 == borders[row, col-1, side]){
                    adjust -= 1
                }
            }
            if((side == "right")||(side == "left")){
                if(1 == borders[row+1, col, side]){
                    adjust -= 1
                }
                if(1 == borders[row-1, col, side]){
                    adjust -= 1
                }
            }
            borders2[row, col, side] = 1
            sum += adjust/2
        }
    }
    #print("sides: " sum)
    return(sum)
}

function get_regions(many_rows, many_cols,     result, sum){
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
