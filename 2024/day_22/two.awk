BEGIN{
    Rounds = 2000
    #Rounds = 10
}
{
    print("")
    print($0)
    s = $0+0
    sequence[1] = 0
    sequence[2] = 0
    sequence[3] = 0
    sequence[4] = 0
    for(i=0; i<Rounds; i++){
        s2 = next_secret(s)
        absorb_sequence(s, s2, sequence)
        s = s2
        if(i > 3){
        if(!((NR, sequence[4], sequence[3], sequence[2], sequence[1]) in Cache)){
            price = s%10
            Cache[NR, sequence[4], sequence[3], sequence[2], sequence[1]] = price
        }
        }
    }
}
END {
    print("END")
    max_sum = 0
    for(key in Cache){
        split(key, a, SUBSEP)
        seq = array2seq_key(a)
        if(!(seq in filled)){
            filled[seq] = 1
            sum = 0
            for(i=1; i<=NR; i++){
                if((i, a[2], a[3], a[4], a[5]) in Cache){
                    price = Cache[i, a[2], a[3], a[4], a[5]]
#                    print("in cache " i "; ", a[2], a[3], a[4], a[5], "; " price)
                    sum += price
                }
            }
            if(sum == 3189){
                print(a[2], a[3], a[4], a[5], sum)
            }
            max_sum = max(sum, max_sum)
            #print(seq "; " sum)
        }
    }
    print(max_sum)
}

function max(a, b){
    if(a > b){return(a)}
    return(b)
}

function array2seq_key(a){
    return(a[2] " " a[3] " " a[4] " " a[5])
}

function absorb_sequence(s1, s2, sequence){
    sequence[4] = sequence[3]
    sequence[3] = sequence[2]
    sequence[2] = sequence[1]
    sequence[1] = (s2%10) - (s1 % 10)
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


