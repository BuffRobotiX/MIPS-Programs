.data
array:	.space 40
minResult: .asciiz "Min: "
n:	.asciiz "\n"
combResult: .asciiz "Comb: "
.text
main:	li $t0, 10
	la $t1, array
mainLoop: li $v0, 5
	syscall
	sw $v0, 0($t1)
	addi $t1, $t1, 4
	addi $t0, $t0, -1
	bnez $t0, mainLoop
	
	la $a0, array
	li $a1, 0
	li $a2, 9
	jal min
	move $t0, $v0
	li $v0, 4
	la $a0, minResult
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 4
	la $a0, n
	syscall
	li $v0, 5
	syscall
	move $a0, $v0
	li $v0, 5
	syscall
	move $a1, $v0
	jal comb
	move $t0, $v0
	li $v0, 4
	la $a0, combResult
	syscall
	move $a0, $t0
	li $v0, 1
	syscall
	
	li $v0, 10
	syscall
	
min:	bne $a1, $a2, minCon
	sll $a1, $a1, 2
	add $t0, $a0, $a1
	lw $v0, 0($t0)
	jr $ra
minCon:	addiu $sp, $sp, -20
	sw $ra, 0($sp)
	sw $a0, 4($sp)
	sw $a2, 8($sp)
	add $a2, $a1, $a2
	srl $a2, $a2, 1
	sw $a2, 12($sp)
	jal min
	sw $v0, 16($sp)
	lw $a0, 4($sp)
	lw $a2, 8($sp)
	lw $a1, 12($sp)
	addi $a1, $a1, 1
	jal min
	lw $t0, 16($sp)
	lw $ra, 0($sp)
	addiu $sp, $sp, 20
	bgt $t0, $v0, minGreat
	move $v0, $t0
minGreat: jr $ra

comb:	beq $a0, $a1, combDone
	beqz $a1, combDone
	addiu $sp, $sp, -16
	sw $ra, 0($sp)
	addi $a0, $a0, -1
	sw $a0, 4($sp)
	sw $a1, 8($sp)
	jal comb
	sw $v0, 12($sp)
	lw $a0, 4($sp)
	lw $a1, 8($sp)
	addi $a1, $a1, -1
	jal comb
	lw $t0, 12($sp)
	add $v0, $t0, $v0
	lw $ra, 0($sp)
	addiu $sp, $sp, 16
	jr $ra
combDone: li $v0, 1
	jr $ra