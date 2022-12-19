; Check whether the digit is even or odd.

section .data
msg1 : db  'Enter a number :'
l1 : equ $-msg1
ans1 : db 'even',10
la1 : equ $-ans1
ans2 : db 'odd',10
la2 : equ $-ans2

section .bss
d1 : resb 1
r : resb 1

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


	mov ax, word[d1]
	mov ah, 0								; Not necessary(But it always good practice to add zeros to top bits if they are not occupied)
	mov bl, 2
	div bl
	
	cmp ah, 0
	je if									; je is for if both are equal.
										; Standard way to implement if else statements.
	else :
		mov eax, 4
		mov ebx, 1
		mov ecx, ans2
		mov edx, la2
		int 80h
		jmp L


	if:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans1
		mov edx, la1
		int 80h
	L:

	mov eax, 1
	mov ebx, 0
	int 80h




