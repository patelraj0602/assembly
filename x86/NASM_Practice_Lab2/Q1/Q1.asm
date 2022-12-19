section .data
msg : db 'Enter any key :'
l : equ $-msg
ans1 : db 'Alert! Your Caps Lock is on',10
l1 : equ $-ans1
ans2 :db 'Your Caps Lock is off',10
l2 : equ $-ans2

section .bss
d1 : resb 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg
	mov edx, l
	int 80h

	mov eax, 3
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h
	
	;mov bl, 0
	mov al, byte[d1]
	
	cmp al,'A'								; 1 if al is greater than A
	setnc bl
	
	cmp al, 'Z'+1								; 1 if bl is less than or equal to Z
	setc bh
	
	and bl, bh

	cmp bl, 1
	je if


	else:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans2
		mov edx, l2
		int 80h
		jmp L

	if:
		mov eax, 4
		mov ebx, 1
		mov ecx, ans1
		mov edx, l1
		int 80h

	L:
		mov eax, 1
		mov ebx, 0
		int 80h
		
