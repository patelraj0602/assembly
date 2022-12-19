; Check whether the first digit is multiple of second digit or not.

section .data
msg1 : db 'Enter the first digit : '
l1 : equ $-msg1
msg2 : db 'Enter the second digit : '
l2 : equ $-msg2
msg3 : db 'First digit is multiple of second digit.', 10
l3 : equ $-msg3
msg4 : db 'First digit is not multiple of second digit.', 10
l4 : equ $-msg4

section .bss
d1 : resb 1
d2 : resb 1
junk: resb 1

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
	
	mov eax, 3
	mov ebx, 0
	mov ecx, junk
	mov edx, 1
	int 80h
	
	;Performing division
	mov al, byte[d1]
	sub al, 30h
	mov ah, 0
	mov bl, byte[d2]
	sub bl, 30h
	div bl
	
	cmp ah, 0
	je if
	
	else:
		mov eax, 4
		mov ebx, 1
		mov ecx, msg4
		mov edx, l4
		int 80h		
		jmp L
	
	if:
		mov eax, 4
		mov ebx, 1
		mov ecx, msg3
		mov edx, l3
		int 80h
	L:
		mov eax, 1
		mov ebx, 0
		int 80h
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
