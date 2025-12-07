input

var position 50 position !
var acc
var limit 0 line limit !

: fix-position position @ 100 % 100 + 100 % 
  0 = if acc @ 1 + acc ! else then
  position !
;
: main .s
  limit @ 1 - >
  if
    drop drop return
  else
    drop
    dup line 1 1 substr2 swap
    dup line 2 substr rot
    ." L " = 
    if
      drop -1 clicks call
    else
      drop 1 clicks call
    then
    drop drop 1 +
    recurse
    then
;
: clicks #steps, direction --
   #take this many steps in this direction.
   swap #d s 
   1 < if #d s
     drop return
   else
     drop swap dup #steps, direction, direction
     position @ #s d d p
     + #s d d+p
     position ! #s d
     fix-position call
     swap 1 - swap # s d
     recurse
   then
 ;
1 main call
acc @ .s