#V = one length per time

BEGIN{
    acc = 1
}

/Time:/{
   split($0, a, ":")
   times = a[2]
}
/Distance:/{
   split($0, a, ":")
   distances = a[2]
}

END{
    split(times, t)
    many = split(distances, d)
    for(i=1; i<=many; i++){
        sum = 0
        for(j=0; j<=t[i]; j++){
            V = j
            D = V * (t[i] - j)
            if(D > d[i]){
                sum+= 1
            }
        }
        print(sum)
        acc *= sum
    }
    print(acc)
}
