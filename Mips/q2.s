# The code will print yes if the given numbers are twin prime else it will print no.

.data
msg1 : .asciiz "Enter the first number : "
msg2 : .asciiz "Enter the second number : "
yes : .asciiz "The given numbers are twin prime"
no : .asciiz "The given numbers are not twin prime"
space : .asciiz " "
nl : .asciiz "\n"

.text
.globl main
main:
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0
	move $t5, $v0
	jal isPrime
	move $s0, $v0
	
	li $v0, 4
	la $a0, msg2
	syscall
	
	li $v0, 5
	syscall
	move $a0, $v0
	move $t6, $v0
	jal isPrime
	move $s1, $v0
	
	and $t2,$s0,$s1
	beq $t2,$0,else
	
	# Changing the order such that $t5 will contain smaller number
	
	blt $t5,$t6,jump_here
	move $s5,$t5
	move $t5,$t6
	move $t6,$s5	
	
jump_here:
	
	addi $t5,2	
	bne $t5,$t6,else
	
	li $v0, 4
	la $a0, yes
	syscall
	j end
	
else:
	
	li $v0, 4
	la $a0, no
	syscall

end:
	li $v0, 4
	la $a0, nl
	syscall

	li $v0, 10
	syscall



# Subroutine
isPrime:
	move $t0, $a0
	move $v0, $0
	li $t1, 2
	li $t2, 1
	
	beq $t0,$t2,notPrime
	
	for:
		bge $t1,$t0,prime
		
		rem $t3,$t0,$t1
		beq $t3,$0,notPrime
		addi $t1,1
		j for
		
prime:
	addi $v0,1
	
notPrime:
jr $ra
	
	







