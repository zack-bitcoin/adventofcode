example

#3 .s 3 .s drop .s

#return

: grow 1000 < if drop dup * recurse else drop then ;

2 grow call

.s
.s