; Prints the correct value upto 2^32-1 values.

section .data
msg1 : db 'Enter the first number : '
l1 : equ $-msg1
msg2 : db 'Enter the second number : '
l2 : equ $-msg2
newl : db ' ', 10
l3 : equ $-newl

section .bss
num : resd 1
count: resb 1
temp: resb 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_num

	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	mov eax, dword[num]
	call read_num
	add eax, dword[num]
	
	mov [num], eax
	call print_num

	mov eax, 4
	mov ebx, 1
	mov ecx, newl
	mov edx, l3
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
	



	;These are all function calls.

	;Function to Take input.
	read_num:										
	pusha						

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
	
	
	
	
	; Function to print output.
	;Printing an multiple digit number.
	
	print_num:									
	mov byte[count],0
	pusha
	
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
	
	end_print:
		mov eax,4
		mov ebx,1
		mov ecx,newl
		mov edx,1
		int 80h
		
	popa
	ret												
	
; 1. The pusha and popa are used to preserve the values of the registers even after calling any function. So your data in register will remain intact before and after calling functions.
; 2. use this simple syntex to call fucntion [call (function_name)].
; 3.These functions work with fixed variables So after every function call we have to shift the data inside variables to someother valiable. So that we can get new data in that variable if we call   	;   fucntion later.(For example this read and print data functions always deal with num variable. So after every call we have to shift the content of num to some other variable).



	
