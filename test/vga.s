 .org 0x0
    .set noat
    .set noreorder
    .set nomacro
    .global _start
_start:
	addiu	$1, $0, 52100
	add		$1, $1, $1
	add		$1, $1, $1		# 52100*4=208400=800*260+400��640*480�ֱ��ʴ������λ��
	addiu	$2, $0, 1		# ����
	addiu	$3, $0, 2		# ����
	addiu	$4, $0, 3		# ����
	addiu	$5, $0, 4		# ����
	addiu	$7, $0, 1		# �����ƶ�λ����
	addiu	$8, $0, 800		# �����ƶ�λ����
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
	sub		$1, $1, $7	# λ��-1������һ������
	addi	$6, $0, 0	# ���ƼĴ�����0
	j		wait
	nop
right:
	add		$1, $1, $7	# λ��+1������һ������
	addi	$6, $0, 0	# ���ƼĴ�����0
	j		wait
	nop
up:
	sub		$1, $1, $8	# λ��-800������һ������
	addi	$6, $0, 0	# ���ƼĴ�����0
	j		wait
	nop
down:
	add		$1, $1, $8	# λ��+800������һ������
	addi	$6, $0, 0	# ���ƼĴ�����0
	j		wait
	nop
