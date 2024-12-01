#V = one length per time

#given T and D find t, st
# t * (T-t) = D
# t*T - t^2 - D = 0
# t^2 - t*T + D = 0
# t = (T +- sqrt(T*T - 4*D))/2

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
    gsub(" ", "", times)
    gsub(" ", "", distances)
    print(times " " distances)
    sr = sqrt((times*times) - (4*distances))
    t1 = (times + sr)/2
    t2 = (times - sr)/2
    print(int(t1) - int(t2))
}
