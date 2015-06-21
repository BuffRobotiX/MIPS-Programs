.data
array:	.space	480
prompt:	.asciiz	"Enter a name, age, and salary: "
name:	.asciiz "\nName: "
age:	.asciiz "Age: "
salary:	.asciiz "\nSalary: "
swapPrompt: .asciiz "\nEnter the two indices to swap: "
outOfBounds: .asciiz "Index out of bounds."
.text
main:	li $t0, 10
	la $t1, array
inputLoop: la $a0, prompt
	li $v0, 4
	syscall
	move $a0, $t1
	li $a1, 40
	li $v0, 8
	syscall
	li $v0, 5
	syscall
	sw $v0, 40($t1)
	li $v0, 5
	syscall
	sw $v0, 44($t1)
	addi $t0, $t0, -1
	addi $t1, $t1, 48
	bnez $t0, inputLoop
	
	li $t0, 10
	la $t1, array
printLoop: la $a0, name
	li $v0, 4
	syscall
	move $a0, $t1
	li $v0, 4
	syscall
	la $a0, age
	li $v0, 4
	syscall
	lw $a0, 40($t1)
	li $v0, 1
	syscall
	la $a0, salary
	li $v0, 4
	syscall
	lw $a0, 44($t1)
	li $v0, 1
	syscall
	addi $t0, $t0, -1
	addi $t1, $t1, 48
	bnez $t0, printLoop
	
swap:	la $a0, swapPrompt
	li $v0, 4
	syscall
	li $v0, 5
	syscall
	blt $v0, 0, error
	bgt $v0, 9, error
	move $t0, $v0
	li $v0, 5
	syscall
	blt $v0, 0, error
	bgt $v0, 9, error
	la $t1, array
	mul $t0, $t0, 48
	mul $v0, $v0, 48
	add $t2, $t1, $t0
	add $t3, $t1, $v0
	li $t4, 12
	
swapLoop: lw $t5, 0($t2)
	lw $t6, 0($t3)
	sw $t5, 0($t3)
	sw $t6, 0($t2)
	addi $t4, $t4, -1
	addi $t2, $t2, 4
	addi $t3, $t3, 4
	bnez $t4, swapLoop
	li $v0, 10
	syscall
	
	error: la $a0, outOfBounds
	li $v0, 4
	syscall
	b swap
	li $v0, 10
	syscall
