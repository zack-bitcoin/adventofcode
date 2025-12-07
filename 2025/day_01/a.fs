input

var position
50 position !

var acc

var limit
0 line limit !

: fix-position position @ 100 % 100 + 100 % 
  0 = if acc @ 1 + acc ! else then #landed on zero! update the accumulator.
position ! ;

: main
  limit	@ >
  if
    drop drop return
  else
    drop
    dup line 1 1 substr2 swap
    dup line 2 substr rot
    ." L " = 
    if
      drop position @ swap -
    else
      drop position @ swap +
    then
    position ! fix-position call
    1 +
    recurse
  then
;

 1 main call
." result: " acc @ .s