 .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
	lui $1, 0x8001
	lui $22, 0x8002
	lui $2, 0x0001
	lui $3, 0x0002
	lui $4, 0x8002
	lui $5, 0x0003
	
	add $5,$1,$2
	addu $6,$1,$2
	sub $7,$1,$2
	subu $8,$1,$2
	and $9,$1,$2
	or $10,$1,$2
	xor $11,$1,$2
	nor $12,$1,$2
	slt $13,$1,$2
	sltu $14,$1,$2
	addi $15,$2,0x8001
	addiu $16,$2,0x8001
	andi $17,$2,0x8001
	ori $18,$2,0x8001
	xori $19,$2,0x8001
	sw $1,0x2000($0)
	lw $1,0x2000($0)
