.data
msg1 : .asciiz "Enter the String : "
msg2 : .asciiz "Enter the string which need to be replaced : "
msg3 : .asciiz "Enter the replaced string : "
space : .asciiz " "
nl : .asciiz "\n"
buffer1: .space 256
temp1: .space 100
temp2: .space 100
temp: .space 100

.text
.globl main
main:

	# Taking input Strings.

	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0,8
	la $a0, buffer1
	li $a1, 256
	syscall
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0,8
	la $a0, temp1
	li $a1, 100
	syscall
	
	li $v0, 4
	la $a0, msg3
	syscall
	
	li $v0,8
	la $a0, temp2
	li $a1, 100
	syscall
	
	
	# Adding zeros at the end.
	la $a0, buffer1
	jal helper
	
	la $a0, temp1
	jal helper
	
	la $a0, temp2
	jal helper
	
	la $t0,buffer1
  	move $t2,$0

looping:
	# Reinitializing for next word.
	la $t1, temp
	move $t3,$0
	
	in_loop:
		add $t4,$t0,$t2
		lb $t5,0($t4)
		
		# Checking if Jumping is required.
		li $t6, 32
		beq $t5,$t6,word
		beq $t5,$0, word
	
		add $t6,$t1,$t3
		sb $t5,0($t6)
		
		addi $t2,1
		addi $t3,1
		j in_loop
	
	word:
		add $t6,$t1,$t3
		sb $0,0($t6)
		
		jal canChange
		move $t7,$v0
		beq $t7,$0,not_same
		
		la $a0,temp2
		li $v0,4
		syscall
		
		la $a0,space
		li $v0,4
		syscall
		
		j else
		
	not_same:
		la $a0,temp
		li $v0,4
		syscall
		
		la $a0,space
		li $v0,4
		syscall
		
	else:
	
		beq $t5,$0,end
		addi $t2,1
		j looping
	
end:

li $v0, 4
la $a0, nl
syscall

li $v0, 10
syscall



canChange:	
	move $v0, $0
	move $s0,$0
	
	la $s1, temp
	la $s2, temp1
	
	loop_here:
		add $s3,$s1,$s0
		add $s4,$s2,$s0
		
		lb $s5,0($s3)
		lb $s6,0($s4)
		
		bne $s5,$s6,exit
		beq $s5,$0,here
		
		addi $s0,1
		j loop_here

	here:
		addi $v0,1
	exit:
jr $ra


helper:
move $t0,$0	
move $t1, $a0
li $t2, 10

helpLoop:
	add $t3,$t1,$t0
	lb $t4,0($t3)
	beq $t4,$t2,exithelp
	
	addi $t0,1
	j helpLoop
	
exithelp:
	sb $0,0($t3)
jr $ra

