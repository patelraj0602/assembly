; Not my solution.

section .data
msg1 : db 'Enter first number :'
l1 : equ $-msg1
msg2 : db 'Enter second number :'
l2 : equ $-msg2
msg3 : db ' ',10
l3 : equ $-msg3

section .bss
d1 : resb 1
d2 : resb 1
junk : resb 1
num :resb 1
pro :resw 1
half : resb 1
oneplus : resb 1
a : resb 1
b : resb 1
counter : resb 1


section .text
	global _start:
	_start:
	
	mov eax,4
	mov ebx,1
	mov ecx,msg1
	mov edx,l1
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,d1
	mov edx,1
	int 80h
	
	mov eax,3
	mov ebx,0
	mov ecx,junk
	mov edx,1
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,msg2
	mov edx,l2
	int 80h
	
	
	mov eax,3
	mov ebx,0
	mov ecx,d2
	mov edx,1
	int 80h
	
	sub byte[d1],30h
	sub byte[d2],30h
	
	mov al,byte[d1]
	mov bl,byte[d2]
	cmp al,bl
	jnl if
	
	else:
		mov al,byte[d1]
		mov bl,byte[d2]
		mov [a],bl
		mov [b],al
		jmp tata
		
			
	if:
		mov al,byte[d1]
		mov bl,byte[d2]
		mov [a],al
		mov [b],bl
		
	
	tata:
	add byte[a],30h
	add byte[b],30h
	
	loop:
	mov ax,word[a]
	mov ah,0
	mov bl,byte[b]
	div bl
	mov [a],bl
	mov [b],ah
	cmp ah,0
	jne loop
	
	add byte[a],30h
	
	mov eax,4
	mov ebx,1
	mov ecx,a
	mov edx,1
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h
	
	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
	
	
