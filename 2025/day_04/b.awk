# 00:20:05
#rank 2819

BEGIN{
    frame_number = 0
}
{
    Cols = length($0)
    for(i=1; i<=Cols; i++)
        Grid[NR][i] = substr($0, i, 1)
}
END{
    mainloop()
    print("final sum: " sum)
    system("sleep 0.5")
    system("convert -delay 10 -loop 0 frame*.jpg vid.mp4")
    system("rm frame*")
    print("now convert to gif\n")
    system("convert vid.mp4 vid.gif")
}
function mainloop(){
    result = round()
    make_image()
    sum += result
    clear()
    if(result > 0)
        mainloop()
}
function clear(        i, j, g) {
    for(i=1; i<= NR; i++)
        for(j=1; j<=Cols; j++)
            if(Grid[i][j] == "x")
                Grid[i][j] = "."
}
function round(      result, i, j, M){
    result = 0
    for(i=1; i<=NR; i++)
        for(j=1; j<=Cols; j++)
            if(Grid[i][j] == "@")
                if(many_neighbors(i, j) < 5){
                    Grid[i][j] = "x"
                    result += 1
                }
    return(result)
}
function many_neighbors(row, col,         i, j, r){
    r = 0
    for(i=-1; i<=1; i++)
        for(j=-1; j<=1; j++)
            r += is_roll(row + i, col + j)
    return(r)
}
function is_roll(row, col,        g){
    if((row in Grid) && (col in Grid[row])){
        g = Grid[row][col]
        return(("@" == g) || ("x" == g))
    }
    return(0)
}
function make_image() {
    width = Cols
    height = NR
    if((height % 2) == 1)
        height += 1
    if((width % 2) == 1)
        width += 1
    s = "P2\n"width " " height"\n2\n"
    for(y=0; y<height; y++)
        for(x=0; x<width; x++){
            g = Grid[y+1][x+1]
            if(g == "@"){ color = "2"}
            else if(g == "."){ color = "1"}
            else if(g == "x"){ color = "0"}
            s = s color "\n"
        }
    filename = "frame" (10000 + frame_number)
    frame_number += 1
    print(s) > (filename ".ppm")
    system("convert "filename".ppm "filename".jpg")
    system("rm " filename".ppm ")
}
