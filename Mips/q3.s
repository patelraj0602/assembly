.data
msg1: .asciiz"Enter first string : "
msg2: .asciiz"Enter second string : "
msg3: .asciiz"The concatinated string is : "
space: .asciiz" "
newline: .asciiz"\n"
buffer1: .space 256
buffer2: .space 256

.text
.globl main
main:
	li $v0,4
	la $a0,msg1
	syscall
	
	li $v0,8
	la $a0, buffer1
	li $a1, 256
	syscall
	
	li $v0,4
	la $a0,msg2
	syscall
	
	li $v0,8
	la $a0, buffer2
	li $a1, 256
	syscall

li $v0,4
la $a0,msg3
syscall

	li $s0,10
	la $t0, buffer1
	la $t1, buffer2
	move $t2,$0 
	
looping1:
	add $t3,$t0,$t2
	lb $t4,0($t3)
	beq $t4,$s0,outloop1
	
	li $v0,11
	move $a0,$t4
	syscall
	
	addi $t2,1
	j looping1
outloop1:

	move $t2,$0
looping2:
	add $t3,$t1,$t2
	lb $t4,0($t3)
	beq $t4,$s0,outloop2
	
	li $v0,11
	move $a0,$t4
	syscall
	
	addi $t2,1
	j looping2
outloop2:
	
end:
	
	li $v0,4
	la $a0,newline
	syscall
	
	
	li $v0,10
	syscall
	
