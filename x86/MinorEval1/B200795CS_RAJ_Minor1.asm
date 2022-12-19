section .data
msg1 : db 'Sum = '
l1 : equ $-msg1
msg2 : db 'Result = ' 
l2 : equ $-msg2
newl : db ' ', 10
l3 : equ $-newl

section .bss
d1 : resb 1
d2 : resb 1
junk: resb 1
num : resw 1
count: resb 1
temp: resb 1
ans: resb 1
sum: resb 1

section .text

	global _start:
	_start:

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

	mov eax, 3
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h
	
	sub byte[d1], 30h
	sub byte[d2], 30h
	
	mov al, 0
	mov cl, byte[d1]
	add cl, 1

	for:
		cmp cl, byte[d2]
		jnb L
		
		add al, cl	
		add cl, 1									
		jmp for

	
	

	L: 
		mov [num], al
		mov [sum], al
			
		mov eax, 4
		mov ebx, 1
		mov ecx, msg1
		mov edx, l1
		int 80h
	
		call print_num
		
		mov eax, 4
		mov ebx, 1
		mov ecx, newl
		mov edx, l1
		int 80h
	
		mov eax, 4
		mov ebx, 1
		mov ecx, msg2
		mov edx, l2
		int 80h
		
		mov ax, word[sum]	
		mov bl, 5
		div bl
		add al, 30h
		mov [ans], al
	
	
		mov eax, 4
		mov ebx, 1
		mov ecx, ans
		mov edx, 1
		int 80h
	
		mov eax, 4
		mov ebx, 1
		mov ecx, newl
		mov edx, l1
		int 80h
	

	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
	print_num:									
	mov byte[count],0
	pusha
	
	extract_no:
		cmp word[num], 0
		je print_no
	
		inc byte[count]
		mov dx, 0
		mov ax, word[num]
		mov bx, 10
		div bx
		push dx										
		
		mov word[num], ax
		jmp extract_no
	
	print_no:
		cmp byte[count], 0
		je end_print
		
		dec byte[count]
		pop dx
		mov byte[temp], dl
		add byte[temp], 30h
			
		mov eax, 4
		mov ebx, 1
		mov ecx, temp
		mov edx, 1
		int 80h
	
		jmp print_no
	
	end_print:
		mov eax,4
		mov ebx,1
		mov ecx,newl
		mov edx,1
		int 80h
		
	popa
	ret		
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
			

