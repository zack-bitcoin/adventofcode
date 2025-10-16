BEGIN {
    X = 0
    Max = 0
}

/[0-9]+/ {
    X = X + $0
}

/^$/ {
    if (X > Max) {
        Max = X
    }
    X = 0
}

END {
    print(Max)
}
