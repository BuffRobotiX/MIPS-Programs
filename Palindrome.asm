.data
string: .space 100
prompt: .asciiz "Enter a string: "
messageUpper: .asciiz "Number of uppercase characters: "
messageLower: .asciiz "\nNumber of lowercase characters: "
messageSpace: .asciiz "\nNumber of space characters: "
messagePalindrome1: .asciiz "\nThe string is "
messagePalindrome2: .asciiz "not "
messagePalindrome3: .asciiz "a palindrome."

.text
main: li $v0, 4
la $a0, prompt
syscall
li $v0, 8
la $a0, string
li $a1, 99
syscall
li $s0, 0	#space counter
li $s1, 0	#uppercase counter
li $s2, 0	#lowercase counter
mainLoop: lb $t0, 0($a0)
addi $a0, $a0, 1 #inc the address
beqz $t0, loopEnd #null char
beq $t0, 32, space #the char is a space
bgt $t0, 64, upper #char is either uppercase or lowercase or garbage
b mainLoop
space: addi $s0, $s0, 1 #inc the space counter
b mainLoop
upper: bgt $t0, 96, lower #lowercase or greater
bgt $t0, 90, mainLoop #random char
addi $s1, $s1, 1 #if it made it past those checks, it is an uppercase char
b mainLoop
lower: bgt $t0, 122, mainLoop
addi $s2, $s2, 1
b mainLoop

loopEnd: li $v0, 4
la $a0, messageUpper
syscall
li $v0, 1
move $a0, $s1
syscall
li $v0, 4
la $a0, messageLower
syscall
li $v0, 1
move $a0, $s2
syscall
li $v0, 4
la $a0, messageSpace
syscall
li $v0, 1
move $a0, $s0
syscall

la $a0, string
jal palindrome
move $t0, $v0
li $v0, 4
la $a0, messagePalindrome1
syscall
beqz $t0, palindromed
end: li $v0, 4
la $a0, messagePalindrome3
syscall
li $v0, 10
syscall
palindromed: li $v0, 4
la $a0, messagePalindrome2
syscall
b end

palindrome: li $v0, 1 #true or false
move $t0, $a0
getLength: lb $t1, 0($t0)
beqz $t1, gotLength
addi $t0, $t0, 1
b getLength
gotLength: addi $t0, $t0, -2
palinLoop: beq $a0, $t0, palinDone
bgt $a0, $t0, palinDone #if the pointers are the same or $a0 has surpassed $t0, we're done
lb $t1, 0($a0) #first char
lb $t2, 0($t0) #last char
addi $a0, $a0, 1
addi $t0, $t0, -1
bne $t1, $t2, palinFail
b palinLoop
palinFail: li $v0, 0
palinDone: jr $ra