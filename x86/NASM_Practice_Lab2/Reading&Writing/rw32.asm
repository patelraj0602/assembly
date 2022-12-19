; Read and Prints the correct value upto 2^32-1 values.

section .data
msg1 : db 'Enter the number : '
l1 : equ $-msg1
newl : db ' ', 10
l3 : equ $-newl

section .bss
num : resd 1
count: resb 1
temp: resb 1
zero: resb 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h



	; Taking input.
	
	;read_num:										
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
	;ret											
	
	
	
	
	
	;Printing an multiple digit number.
	
	;print_num:									
	mov byte[count],0
	pusha
	
	cmp dword[num],0									; For the edge case when the value inside of num is zero.
	je print_zero
	
	extract_no:
		cmp dword[num], 0
		je print_no
	
		inc byte[count]
		mov edx, 0
		mov eax, dword[num]
		mov ebx, 10
		div ebx
		push edx									; We have to pop into 32 bit register only because we pushed content of 32 bit register.
		
		mov dword[num], eax
		jmp extract_no
	
	print_no:
		cmp byte[count], 0
		je end_print
		
		dec byte[count]								; Very important note:
		pop edx									; We have to pop into 32 bit register only because we pushed content of 32 bit register.
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
	;ret											

	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
	
	
	
	
