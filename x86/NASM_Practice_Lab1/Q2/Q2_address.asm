;Read your name and print it

section .data
msg1 :db 'Enter your name :'
l1 : equ $-msg1

section .bss
name : resb 1						;resb 1 =>allocate 1 byte.(operator size)
l : resb 1						;resw 1 =>allocate 2 byte. 

section .text

global _start:
_start:
	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	mov eax, 3					; Sys_call number for read.
	mov ebx, 0					; To input via keyboard.
	mov ecx, name					; Pointer to the memory location where input is stored.
	mov edx, l					; Stores the lenght of the input.
	int 80h					; Calling an interrupt.
							; By default the printing happens on new line only.

	mov eax, 4
	mov ebx, 1
	mov ecx, name					
	mov edx, l					
	int 80h
	
	mov eax, 4
	mov ebx, 1
	mov ecx, name					
	mov edx, l					
	int 80h

	mov eax, 1					; exit()
	mov ebx, 0
	int 80h
