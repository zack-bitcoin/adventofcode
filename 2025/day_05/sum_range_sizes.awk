{
    sum += ($2 - $1 + 1)
}

END {
    print("result: " sum)
}
