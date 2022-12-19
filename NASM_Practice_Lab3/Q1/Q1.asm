; No of odd and even numbers from n given numbers.

section .data
msg1 : db 'Enter size of array :'
l1 : equ $-msg1
msg2 : db 'Enter elements of array',10
l2 : equ $-msg2
msg3 : db 'Number of even numbers :'
l3 : equ $-msg3
msg4 : db 'Number of odd numbers :'
l4 : equ $-msg4
endl : db 10
l : equ $-endl
zero : db 30h
lz : equ $-zero

section .bss
num_of_ele : resd 1
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
	
	mov ecx, dword[num_of_ele]										; To use looping construct we have to use ecx register only.
	mov dword[odd_count], 0
	mov dword[even_count], 0
	
	counting:
		push ecx
		call read_number
		mov eax, dword[temporary_num]
		mov ebx, 2
		mov edx, 0
		div ebx

		cmp edx, 1
		je odd
		
		add dword[even_count], 1
		jmp L

		odd:
			add dword[odd_count], 1
		
		L:
			pop ecx
			loop counting

	mov eax, 4
	mov ebx, 1
	mov ecx, msg3
	mov edx, l3
	int 80h

	mov eax, dword[even_count]
	mov dword[temporary_num], eax
	call print_number

	mov eax, 4
	mov ebx, 1
	mov ecx, endl
	mov edx, l
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, msg4
	mov edx, l4
	int 80h

	mov eax, dword[odd_count]
	mov dword[temporary_num], eax
	call print_number

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


	print_number:
	pusha
		mov dword[nod], 0
		
		cmp dword[temporary_num], 0
		jne extracting
			mov eax, 4
			mov ebx, 1
			mov ecx, zero
			mov edx, lz
			int 80h
		jmp allOver

		extracting:

			cmp dword[temporary_num], 0
			je printing
			add dword[nod], 1
			mov eax,dword[temporary_num]
			mov edx, 0
			mov ebx, 10
			div ebx
			push edx
			mov dword[temporary_num], eax
			jmp extracting

		printing:
			cmp dword[nod], 0
			je allOver

			sub dword[nod], 1
			pop edx
			add edx, 30h
			mov dword[temp], edx
			mov eax, 4
			mov ebx, 1
			mov ecx, temp
			mov edx, 4
			int 80h
			jmp printing

		allOver:

	popa
	ret
