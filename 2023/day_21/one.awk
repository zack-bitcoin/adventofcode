/S/ {
    cols = length($0)
    match($0, /S/)
    col_start = RSTART
    row_start = NR
}

{
    for(i=1; i<=length($0); i++){
        Grid[NR, i] = substr($0, i, 1)
    }
}

END {
    rows = NR
    Grid[row_start, col_start] = "O"
#    take_step(Grid)
    take_n_steps(64, Grid)

    sum = sum_Os(Grid)
    print(sum)

}
function sum_Os(Grid){
    sum = 0
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            if(Grid[i, j] == "O"){
                sum+=1
            }
        }
    }
    return(sum)
}
function take_n_steps(n, Grid){
    if(n == 0){return(0)}
    take_step(Grid)
    take_n_steps(n-1, Grid)
}

function print_grid(Grid,     i, j, s){
    for(i=1; i<=rows; i++){
        s = ""
        for(j=1; j<=cols; j++){
            s = s Grid[i, j]
        }
        print(s)
    }
}
function make_grid2(Grid, Grid2){
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            letter = Grid[i, j]
            if(letter == "O"){
                Grid2[i, j] = "."
            } else {
                Grid2[i, j] = Grid[i, j]
            }
        }
    }
}

function update_grid(From, To){
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            To[i, j] = From[i, j]
        }
    }
}

function read_letter(row, col, g){
    g = Grid[row, col]
    if(g){
        return(g)
    } else {
        return("#")
    }
}

function take_step(Grid,           Grid2){
    make_grid2(Grid, Grid2)
    for(i=1; i<=rows; i++){
        for(j=1; j<=cols; j++){
            letter = Grid[i, j]
            if(letter == "O"){
                if(read_letter(i, j+1) == "."){
                    Grid2[i, j+1] = "O"
                }
                if(read_letter(i, j-1) == "."){
                    Grid2[i, j-1] = "O"
                }
                if(read_letter(i+1, j) == "."){
                    Grid2[i+1, j] = "O"
                }
                if(read_letter(i-1, j) == "."){
                    Grid2[i-1, j] = "O"
                }
            }
        }
    }
    update_grid(Grid2, Grid)
}
