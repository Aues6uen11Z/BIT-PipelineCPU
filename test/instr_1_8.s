 .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
addi $1 $2 1  
addi $2 $2 2  
add $1 $2 $1
addu $3 $2 $3
sub $6 $2 $2
subu $2 $2 $2
and $2 $1 $6
or  $2 $1 $6
xor $6 $2 $6
nor $1 $2 $1