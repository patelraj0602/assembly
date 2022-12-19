.data
msg1 : .asciiz "Enter the String : "
msg2 : .asciiz "The largest word in the string is : "
msg3 : .asciiz "The smallest word in the string is : "
space : .asciiz " "
nl : .asciiz "\n"
buffer1: .space 256
temp: .space 100
max: .space 1
maxlen: .space 100
min: .space 1
minlen: .space 100

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
	
	# Adding zeros at the end.
	la $a0, buffer1
	jal helper
	
	#initializing the values in max and min
	li $t0,10000
	la $t1,min
	sb $t0,0($t1)
	
	li $t0,0
	la $t1,max
	sb $t0,0($t1)
	
	#initializing the iterators.
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
		
		move $a0, $t3
		jal work
		
		beq $t5,$0,end
		addi $t2,1
		j looping
	
end:

li $v0, 4
la $a0, msg2
syscall

la $a0,maxlen
li $v0,4
syscall

la $a0,nl
li $v0,4
syscall

li $v0, 4
la $a0, msg3
syscall

la $a0,minlen
li $v0,4
syscall

la $a0,nl
li $v0,4
syscall

li $v0, 10
syscall



work:	
	move $s0,$a0
	
	la $s3,max
	lb $s1,0($s3)
	
	la $s3,min
	lb $s2,0($s3)
	
	starting:
		ble $s0,$s1,less
		
		# Copying into maxlen string.
		
		la $s3,temp
		la $s4,maxlen
		move $s5,$0
		
		loopWork1:
			bgt $s5,$s0,beforeless
			add $s6,$s3,$s5
			add $s7,$s4,$s5
			
			lb $s1,0($s6)
			sb $s1,0($s7)
			
			addi $s5,1
			j loopWork1
		
		beforeless:
			la $s3,max
			sb $s0,0($s3)
	
    less:
		bge $s0,$s2,exit
		
		# Copying into minlen string.
		la $s3,temp
		la $s4,minlen
		move $s5,$0
		
		loopWork2:
			bgt $s5,$s0,beforeexit
			add $s6,$s3,$s5
			add $s7,$s4,$s5
			
			lb $s1,0($s6)
			sb $s1,0($s7)
			
			addi $s5,1
			j loopWork2
		
		beforeexit:	
			la $s3,min
			sb $s0,0($s3)
		
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

