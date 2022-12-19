; printing 0 to that number

section .data
msg1 : db 'Enter a number: '	
msg2 : db ' '								; For spaces between output.	
l1 : equ $-msg1							; Length of the string that starts as msg1.

section .bss
d1 : resb 1
counter : resb 1
d: resb 1

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
									
	sub byte[d1], 30h						; To do operations we have to dereference the memory location first.
	mov byte[counter], 0						; We have to specify the operator size.

	for:
		add byte[counter], 30h					; Converting again into ascii value.
		
		mov eax, 4						
		mov ebx, 1
		mov ecx, counter					; Method for printing stuff.
		mov edx, 1						; Size of the input is between 0-9 so 1 byte.
		int 80h
		
		; To give spaces between output.
		mov eax, 4
		mov ebx, 1
		mov ecx, msg2
		mov edx, 1						; 1 because I it's only 1 character(' ') and it takes only 1 byte of memory.
		int 80h
		
		sub byte[counter], 30h
		add byte[counter], 1
		mov bh, byte[counter]					; Not necessary to use bl register we can use any regiter.
									
									; The operator should be of same size.
		cmp bh, byte[d1]					; Comparsion for jump instruction to execute.
		jna for

	mov eax, 1
	mov ebx, 0
	int 80h
	

; Important Take aways
; 1. You cannot use mov instruction to move from one memory location to another memory location. There has to be atleast 1 register.
; 2. While appling any operations like subtration,addition,mov make sure to specify the operator size for the operand which are fetched from the memory.
; 3. For add,sub,mov,cmp instructions you cannont have both memory operands.
; 4. For add,sub,mov,cmp both the operands should be of same size.
; 5. If you want to move content of 8 bit register to 16 bit register then we have to use movzx
