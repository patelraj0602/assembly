; Read and Prints the correct value upto 2^16-1 values.

section .data
msg1 : db 'Enter the number : '
l1 : equ $-msg1
newl : db ' ', 10
l3 : equ $-newl

section .bss
num : resw 1
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



	; Taking input.
	
	;read_num:											;Marks the start of subprogram.
	pusha												;push all the used registers into the stack using pusha

	
	;;store an initial value 0 to variable ’num’
	mov word[num], 0
	
	loop_read:
		; read a digit
		mov eax, 3
		mov ebx, 0
		mov ecx, temp
		mov edx, 1
		int 80h
	
		
		cmp byte[temp], 10									;check if the read digit is the end of number, i.e, the enter-key whose ASCII.
		je end_read
	
		mov ax, word[num]
		mov bx, 10
		mul bx
		mov bl, byte[temp]
		sub bl, 30h
		mov bh, 0
		add ax, bx
		mov word[num], ax
		jmp loop_read
	
	end_read:
	popa												;pop all the used registers from the stack using popa
	;ret												;States the end of subprogram.
	
	
	
	
	
	;Printing an multiple digit number.
	
	;print_num:											;Marks the start of subprogram
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
		push dx										;Pushing the last bit in stack.
		
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
	;ret												;Marks the end of subprogram.

	mov eax, 1
	mov ebx, 0
	int 80h
	
	
	
	
	
	
	
	
