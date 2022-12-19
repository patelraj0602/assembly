;Read an even two-digit number and find how many times it is divisible by 2

section .data
msg1 : db 'Enter the first digit : '
l1 : equ $-msg1
msg2 : db 'Enter the second digit : '
l2 : equ $-msg2
newl : db ' ', 10
l3 : equ $-newl

section .bss
d1 : resb 1
d2 : resb 1
junk: resb 1
ans : resb 1
tmp : resb 1

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
	
	;mov byte[ans], 0
	
	for:
		mov bl, 2
		mov ah, 0								; Makes sure to add zeros here, Else it will through floating point exception.
		div bl
		
		cmp ah, 1
		je L
		
		add byte[ans], 1
		jmp for
	
	L:
		add byte[ans], 30h
	
		mov eax, 4
		mov ebx, 1
		mov ecx, ans
		mov edx, 1
		int 80h
	
		mov eax, 4
		mov ebx, 1
		mov ecx, newl
		mov edx, l3
		int 80h
	

		mov eax, 1
		mov ebx, 0
		int 80h
	
	
	
	
	
	
	
	
