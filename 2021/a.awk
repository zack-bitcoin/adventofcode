BEGIN{
    x = 100000000000000000000000000
}

{
    if($0 > x){
	sum += 1
    }
    x = $0 + 0
}

END{
    print("result " sum)
}
