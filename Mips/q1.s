.data
msg1 : .asciiz "Enter the value of n : "
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
	move $t9, $v0
	
	li $t3,-1
	move $t0,$0
	move $t1,$0
	addi $t0,1
	

	beq $t9,$0,end
	
	li $v0, 1
	move $a0,$0
	syscall
	add $t9,$t9,$t3
	
	
looping:
	beq $t9,$0,end
	
	li $v0, 4
	la $a0, space
	syscall
	
	move $t4,$t1
	add $t1,$t1,$t0
	move $t0,$t4
	
	li $v0, 1
	move $a0,$t1
	syscall
	
	add $t9,$t9,$t3
	j looping

end:
	li $v0, 4
	la $a0, nl
	syscall

	li $v0, 10
	syscall


