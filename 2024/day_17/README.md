
deassembling the program in my input

Program: 2,4,1,1,7,5,4,0,0,3,1,6,5,5,3,0

bst 4 bxl 1 cdv 5 bxc 0 adv 3 bxl 6 out 5 jnz 0

while(!(a==0)){
  b = a % 8
  b = xor(b, 1)
  c = int(a/pow2(b))
  b = xor(b, c)
  a = int(a/8)
  b = xor(b, 6)
  print(b % 8)
  }

We can tell that it is reading values from A one octal value at a time. So, that is why we should look for values of A where if you encode it in octal, it includes certain substrings.