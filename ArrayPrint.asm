		.data
prompt1:	.asciiz "Enter 20 integers: "
prompt2:	.asciiz "\nEnter a positive integer less than or equal to 20: "
message1:	.asciiz "Printing one per line.\n"
message2:	.asciiz "Printing with spaces.\n"
message3:	.asciiz "\nProgrom over, adios amigo!"
newLine:	.asciiz "\n"
space:		.asciiz " "
		.align 4 #word align the array
array:		.space 80 #array of ints which are 4 bytes, 4 * 20 is 80
		.text
main:
	li	$v0, 4		#Code to print a string
	la	$a0, prompt1
	syscall
	li	$t0, 20		#Counter
	la	$t1, array	#Load the starting address of the array

enterLoop:	
	li	$v0, 5		#Code to read an integer
	syscall
	sw	$v0, 0($t1)	#Store the integer
	add	$t1, $t1, 4		#Move the address pointer to the next location
	add	$t0, $t0, -1		#Decrement the counter
	bgtz $t0, enterLoop	#Continue the loop

	li	$t0, 20		#Counter
	la	$t1, array	#Load the starting address of the array
	li	$v0, 4		# Code to print a string
	la	$a0, message1
	syscall

loop1:
	li	$v0, 1		#Code to print an integer
	lw	$a0, 0($t1)	#Load the integer
	syscall
	li	$v0, 4		#Code to print a string
	la	$a0, newLine
	syscall
	add	$t1, $t1, 4		#Move the address pointer to the next location
	add	$t0, $t0, -1		#Decrement the counter
	bgtz $t0, loop1	#Continue the loop

	li	$t0, 20		#Counter
	la	$t1, array	#Load the starting address of the array
	li	$v0, 4		# Code to print a string
	la	$a0, message2
	syscall

loop2:
	li	$v0, 1		#Code to print an integer
	lw	$a0, 0($t1)	#Load the integer
	syscall
	li	$v0, 4		#Code to print a string
	la	$a0, space
	syscall
	add	$t1, $t1, 4		#Move the address pointer to the next location
	add	$t0, $t0, -1		#Decrement the counter
	bgtz $t0, loop2	#Continue the loop

inputN:
	li	$t0, 20		#Counter
	la	$t1, array	#Load the starting address of the array
	li	$v0, 4		#Code to print a string
	la	$a0, prompt2
	syscall
	li	$v0, 5		#Code to read an integer
	syscall
	bgt	$v0, 20, inputN	#Check for less than or equal to 0 and greater than 20
	ble	$v0, 0, inputN
	move $t3, $v0	#Store n
	move $t2, $v0	#Copy n

loop3:
	li	$v0, 1		#Code to print an integer
	lw	$a0, 0($t1)	#Load the integer
	syscall
	li	$v0, 4		#Code to print a string
	la	$a0, space
	syscall
	add	$t1, $t1, 4		#Move the address pointer to the next location
	add	$t0, $t0, -1		#Decrement the counter
	add	$t2, $t2, -1		#Decrement the counter
	beqz $t0, end	#Jump to the end
	bgtz $t2, loop3

	li	$v0, 4		#Code to print a string
	la	$a0, newLine
	syscall
	move $t2, $t3 #Restart loop
	b loop3

end:
	li	$v0, 4		#Code to print a string
	la	$a0, message3
	syscall
	li	$v0, 10
	syscall