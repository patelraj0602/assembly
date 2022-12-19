;Write a Program to Calculate Sum & Average of an Array

section .data
msg1 : db 'Enter size of array :'
l1 : equ $-msg1
msg2 : db 'Enter elements of array',10
l2 : equ $-msg2
msg3 : db 'Number of even numbers :'
l3 : equ $-msg3
msg4 : db 'sum is:'
l4 : equ $-msg4
endl : db 10
l : equ $-endl
zero : db 30h
lz : equ $-zero

section .bss
num : resd 1
count: resb 1
num_of_ele : resd 1
sum : resd 1
ele : resd 1
even_count : resd 1
odd_count : resd 1
temporary_num : resd 1
temp : resb 1
nod : resd 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_number
	mov eax, dword[temporary_num]
	mov dword[num_of_ele], eax
	
	mov ecx, dword[num_of_ele]
	mov dword[odd_count], 0
	mov dword[even_count], 0
    	mov byte[sum], 0

	counting:
	push ecx
		call read_number
		mov eax, dword[temporary_num]
		add byte[sum], al
        
		pop ecx
		loop counting

	
    
	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, l4
	int 80h

	mov al, byte[sum]
	mov dword[num], eax
	call print_num

	mov eax, 4
	mov ebx, 1
	mov ecx, endl
	mov edx, l
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h
	



	read_number:
	pusha

		mov dword[temporary_num], 0
		reading:
			mov eax, 3
			mov ebx, 0
			mov ecx, temp
			mov edx, 1
			int 80h
			
			cmp byte[temp], 10
			je end_reading

			sub byte[temp], 30h
			mov eax, dword[temporary_num]
			mov edx, 0
			mov ebx, 10
			mul ebx
			movzx ebx, byte[temp]
			add eax, ebx
			mov dword[temporary_num], eax
			jmp reading
		end_reading:
	popa
	ret


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
		mov ecx,endl
		mov edx,1
		int 80h
		
	popa
	ret
