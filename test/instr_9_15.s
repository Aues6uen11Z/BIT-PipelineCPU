 .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
    addi     $8, $0, 0xf000		# $8 <- 0xfffff000
    addiu    $9, $0, 0x000f		# $9 <- 0x0000000f
    slt      $10, $8, $9		# $10 <- 1
    slt      $10, $9, $8		# $10 <- 0
    sltu     $10, $9, $8		# $10 <- 1
    sltu     $10, $8, $9		# $10 <- 0
    andi     $9, $8, 0			# $9 <- 0
    ori      $8, $0, 0xffff		# $8 <- 0x0000ffff
    xori     $9, $8, 0x000f		# $9 <- 0x0000fff0
    
    
