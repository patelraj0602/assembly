;Read a 2 digit number and find the sum of even numbers from 0 to that number

section .data
msg1 : db 'Enter the first digit : '
l1 : equ $-msg1
msg2 : db 'Enter the second digit : '
l2 : equ $-msg2
msg5 : db ' ', 10
l5 : equ $-msg5

section .bss
d1 : resb 1
d2 : resb 1
num : resb 1
junk: resb 1
counter: resb 1
a1: resb 1
a2: resb 1
a3: resb 1
a4: resb 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h
	
	mov eax, 3
	mov ebx, 0
	mov ecx, junk
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h
	
	mov al, byte[d1]
	sub al, 30h
	mov bl, 10
	mov ah, 0
	mul bl
	mov bx, word[d2]
	sub bx, 30h
	add ax, bx
	mov [num], ax									; This won't create an issue. But if you try to write [mov byte[num]=ax] then it will throw an error.
											; If memory location is on left side then we don't need to specify word type(but make sure the content coming 												; inside(inside num) does not overflow.
											; If it memory location is on RHS then make sure the size of operands match.
	mov ax, 0
	mov byte[counter], 0

	for:
		add ax, word[counter] 
				
		add byte[counter], 2					
		mov bl, byte[counter]
		cmp bl, byte[num]				
		jna for


	; Sum is inside ax
	mov bx, 1000
	mov dx, 0
	div bx
	add ax, 30h
	mov [a1], ax
	
	mov ax, dx
	mov dx, 0
	mov bx, 100
	div bx
	add ax, 30h
	mov [a2], ax
	
	mov ax,dx
	mov dx, 0
	mov bx, 10
	div bx
	add ax, 30h
	add dx, 30h
	mov [a3], ax									; This a3(1 byte) and ax(2 bytes)==>No issues(just make sure a3 does not overflow)
	mov [a4], dx
	
	
	;Printing first digit
	mov eax, 4
	mov ebx, 1
	mov ecx, a1
	mov edx, 1
	int 80h
	
	;printing second digit.
	mov eax, 4
	mov ebx, 1
	mov ecx, a2
	mov edx, 1
	int 80h
	
	;Printing last 2 digits.
	mov eax, 4
	mov ebx, 1
	mov ecx, a3
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, a4
	mov edx, 1
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg5
	mov edx, l5
	int 80h
	

	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			

