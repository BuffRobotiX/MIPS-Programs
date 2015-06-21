.data
prompt: .asciiz	"Enter 20 integers: "
largeMessage:	.asciiz "\nThe largest number is: "
smallMessage:	.asciiz "The smallest number is: "
divMessage:	.asciiz "\nThe number of integers divisible 4: "
exitMessage:	.asciiz "\nAdios amigo!"
.align 4
array:	.space	80
.text
main:
	li	$v0, 4		#Code to print a string
	la	$a0, prompt
	syscall
	li	$t0, 20		#Counter
	la	$t1, array	#Load the starting address of the array

enterLoop:	
	li	$v0, 5		#Code to read an integer
	syscall
	sw	$v0, 0($t1)	#Store the integer
	add	$t1, $t1, 4	#Move the address pointer to the next location
	add	$t0, $t0, -1	#Decrement the counter
	bgtz $t0, enterLoop	#Continue the loop
	
	jal	smallestLargest
	move	$t0, $v0	#Move the result
	move	$t1, $v1
	li	$v0, 4		#Code to print a string
	la	$a0, smallMessage
	syscall
	li	$v0, 1		#Code to print an integer
	move	$a0, $t1	#Load the integer
	syscall
	li	$v0, 4		#Code to print a string
	la	$a0, largeMessage
	syscall
	li	$v0, 1		#Code to print an integer
	move	$a0, $t0	#Load the integer
	syscall
	
	li	$a0, 4		#Parameter
	jal	divisible
	move	$t0, $v0	#Move the result
	li	$v0, 4		#Code to print a string
	la	$a0, divMessage
	syscall
	li	$v0, 1		#Code to print an integer
	move	$a0, $t0	#Load the integer
	syscall
	
	li	$v0, 4		#Code to print a string
	la	$a0, exitMessage
	syscall
	li	$v0, 10
	syscall
	
smallestLargest:
	la	$t0, array	#Load the starting address of the array
	li	$t1, 20		#Counter
	lw	$v0, 0($t0)	#Load the first integer
	move	$v1, $v0
largeLoop:
	addi	$t0, $t0,  4	#Increment array
	addi	$t1, $t1,  -1	#decrement counter
	beqz	$t1, largeEnd
	lw	$t2, 0($t0)
	bgt	$t2, $v0, larger
	blt	$t2, $v1, smaller
	b	largeLoop
larger:
	move	$v0, $t2
	b	largeLoop
smaller:
	move	$v1, $t2
	b	largeLoop
largeEnd:
	jr	$ra
	
divisible:
	la	$t0, array	#Load the starting address of the array
	li	$t1, 20
	li	$v0, 0		#Counter
divLoop:
	lw	$t2, 0($t0)	#Load the integer
	addi	$t1, $t1, -1
	addi	$t0, $t0, 4
	rem	$t3, $t2, $a0
	beqz	$t3, divInc
	beqz	$t1, divEnd
	b	divLoop
divInc:
	addi	$v0, $v0, 1
	beqz	$t1, divEnd
	b	divLoop
divEnd:
	jr	$ra