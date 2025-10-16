#53:21


BEGIN {
    ls_mode = 0
    pwd = "/"
    dir = "/"

    print("backup test " ("/abc/" == backup("/abc/def/")))
    print("backup test " "/abc/ "  backup("/abc/def/"))
    print("pwd2dir test " ("def" == pwd2dir("/abc/def/")))
    print("pwd2dir test " "def " pwd2dir("/abc/def/"))
}
/\$ cd / {
    s = $0
    s2 = substr(s, 6)
    if(s2 == "/"){
        pwd = "/"
        dir = "/"
    } else if(s2 == ".."){
        pwd = backup(pwd)
        dir = pwd2dir(pwd)
    } else {
        dir = s2
        pwd = pwd dir "/"
    }
}
/\$ ls/ {
    #print("ls line")
    ls_mode = 1
}

/dir / {
    CONTAINS[pwd] = CONTAINS[pwd] "," $2
}

/[0-9]+ / {
    num = $1
    name = $2
    SIZE[pwd] += num
}

function pwd2dir(s,     N, A){
    N = split(s, A, "/")
    return(A[N-1])
}
function backup(s,     N, A, l){
    N = split(s, A, "/")
    l= length(A[N-1])
    return(substr(s, 1, length(s) - l - 1))
}

END {
    print("start the end")
    for (key in CONTAINS) {
        print(key " has " CONTAINS[key])
    }
    print("now size")
    for (key in SIZE) {
        print(key " sized " SIZE[key])
    }

    update_sizes("/")
    #print("after size")
    for (key in SIZE) {
        #print(key " sized " SIZE[key])
    }
    need_to_free = SIZE["/"] - 40000000
    print("need to free " need_to_free)

    best = "/"
    size = SIZE["/"]

    for (key in SIZE) {
        if((SIZE[key] < size) &&
           (SIZE[key] > need_to_free)){
            size = SIZE[key]
        }
    }
    print("size: " size)
}

function update_sizes(dir,       s, A, N, i){
    print("update sizes " dir)
    s = CONTAINS[dir]
    N = split(s, A, ",")
    for(i=2; i<=N; i++){
        update_sizes(dir A[i] "/")
        #print("increase size of " dir " by " A[i] " amount " SIZE[dir  A[i] "/"])
        SIZE[dir] += SIZE[dir A[i] "/"]
    }
}
