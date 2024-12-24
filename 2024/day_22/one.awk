BEGIN{

}
{
    n = nth_secret(2000, $0+0)
    print($0, n)
    sum += n
}
END {
    print("END")
    print(mix(42, 15), 37)
    print(prune(100000000))
    print(16113920)
    print(sum)
}

function nth_secret(n, s){
    for(i=1; i<=n; i++){
        s = next_secret(s)
    }
    return(s)
}

function next_n_secrets(n, s){
    for(i=1; i<=n; i++){
        s = next_secret(s)
        print(s)
    }
}


function mix(a, b){
    return(xor(a, b))
}

function prune(a){
    return(a % 16777216)
}

function next_secret(s){
    s = prune(mix(s*64, s))
    s = prune(mix(int(s/32), s))
    s = prune(mix(s*2048, s))
    return(s)
}
