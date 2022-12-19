				;print your name & address

section .data					;Variables are declared and initialized here.
name : db 'Raj Patel', 10			;This 10 is ascii value fr new line.
l : equ $-name

add1 : db 'A-108 Ajay tenament',0ah
l1 : equ $-add1

add2 : db 'CTM Ahmedabad',0ah
l2 : equ $-add2				; Systex to determine the lenght of the string.

add3 : db 'Gujarat',0ah
l3 : equ $-add3
						; section.bss ==> Here variables are declared

section .text					;Contains the Executable code. Smae as main() in c.

global _start:					;Tells the kernel to start execution from here.
_start:
	mov eax, 4				; Which system task we need to perform.
	mov ebx, 1				; Telling system to print the output on screen.
	mov ecx, name				; The thing which we want to print.
	mov edx, l				; It is the length of the string.
	int 80h				; Way of telling computer to execute an system call.

	mov eax, 4
	mov ebx, 1
	mov ecx, add1
	mov edx, l1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add2
	mov edx, l2
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, add3
	mov edx, l3
	int 80h

	mov eax, 1				;System call for exit() code.
	mov ebx, 0
	int 80h

