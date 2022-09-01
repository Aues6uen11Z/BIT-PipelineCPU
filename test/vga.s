 .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
	addiu	$1, $0, 52100
	add		$1, $1, $1
	add		$1, $1, $1		# 52100*4=208400=800*260+400，640*480分辨率大概中心位置
	addiu	$2, $0, 1		# 向左
	addiu	$3, $0, 2		# 向右
	addiu	$4, $0, 3		# 向上
	addiu	$5, $0, 4		# 向下
	addiu	$7, $0, 1		# 左右移动位移量
	addiu	$8, $0, 800		# 上下移动位移量
wait:
	beq		$2, $6, left
	nop
	beq		$3, $6, right
	nop
	beq		$4, $6, up
	nop
	beq		$5, $6, down
	nop
	j		wait
	nop
left:
	sub		$1, $1, $7	# 位置-1，向左一个像素
	addi	$6, $0, 0	# 控制寄存器清0
	j		wait
	nop
right:
	add		$1, $1, $7	# 位置+1，向右一个像素
	addi	$6, $0, 0	# 控制寄存器清0
	j		wait
	nop
up:
	sub		$1, $1, $8	# 位置-800，向上一个像素
	addi	$6, $0, 0	# 控制寄存器清0
	j		wait
	nop
down:
	add		$1, $1, $8	# 位置+800，向下一个像素
	addi	$6, $0, 0	# 控制寄存器清0
	j		wait
	nop
