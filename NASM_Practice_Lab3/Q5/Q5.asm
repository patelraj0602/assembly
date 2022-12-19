;Write a program to accept 10 numbers into an array and find the largest and smallest number 

section .data
msg1 : db 'Please enter 10 numbers in the following lines.'
l0 : equ $-msg1
msg2 : db 'minimum : '
l1 : equ $-msg2
msg3 : db 'maximum : '
l2 : equ $-msg3
newl : db 10
l3 : equ $-newl

section .bss
array: resd 10
num : resd 1
count: resb 1
temp: resb 1
zero: resb 1
min: resd 1
max: resd 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l0
	int 80h
	
	mov eax,4
	mov ebx,1
	mov ecx,newl
	mov edx,l3
	int 80h
	
	mov ecx, 10
	mov eax, array
	for_reading:
		call read_num
		mov ebx,dword[num]
		mov [eax],ebx
		add eax, 4
		loop for_reading
		
		
	mov dword[max],0
	mov dword[min],4294967295
	mov ecx,10
	mov eax,array
	min_max:
		push ecx
		mov ebx,dword[eax]
	
		cmp ebx,dword[max]
		jb minimum
		mov dword[max], ebx
		
		minimum:	
			cmp ebx,dword[min]
			ja L
			mov dword[min], ebx
		L:
		
		add eax, 4
		pop ecx
		loop min_max
		
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l1
	int 80h
	
	mov eax, dword[min]
	mov [num],eax
	call print_num
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l2
	int 80h
	
	mov eax,dword[max]
	mov [num],eax
	call print_num
	
	mov eax, 1
	mov ebx, 0
	int 80h
	



	; Taking input.
	read_num:										
	pusha						

	
	;store an initial value 0 to variable ’num’
	mov dword[num], 0
	
	loop_read:
		; read a digit
		mov eax, 3
		mov ebx, 0
		mov ecx, temp
		mov edx, 1
		int 80h
	
		
		cmp byte[temp], 10							
		je end_read
	
		mov eax, dword[num]
		mov ebx, 10
		mul ebx
		mov ebx, dword[temp]
		sub ebx, 30h
	
		add eax, ebx
		mov [num], eax
		jmp loop_read
	
	end_read:
	popa											
	ret											
	
	
	
	
	
	;Printing an multiple digit number.
	
	print_num:									
	mov byte[count],0
	pusha
	
	cmp dword[num],0								
	je print_zero
	
	extract_no:
		cmp dword[num], 0
		je print_no
	
		inc byte[count]
		mov edx, 0
		mov eax, dword[num]
		mov ebx, 10
		div ebx
		push edx									
		
		mov dword[num], eax
		jmp extract_no
	
	print_no:
		cmp byte[count], 0
		je end_print
		
		dec byte[count]						
		pop edx								
		mov [temp], edx
		add byte[temp], 30h
			
		mov eax, 4
		mov ebx, 1
		mov ecx, temp
		mov edx, 1
		int 80h
	
		jmp print_no
	
	print_zero:
		mov byte[zero], 30h
		
		mov eax, 4
		mov ebx, 1
		mov ecx, zero
		mov edx, 1
		int 80h
		
	
	end_print:
		mov eax,4
		mov ebx,1
		mov ecx,newl
		mov edx,l3
		int 80h
		
		
	popa
	ret											
