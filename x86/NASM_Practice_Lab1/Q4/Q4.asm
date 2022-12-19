; Adding Two one digit numbers

section .data
msg1 : db 'Enter first digit :'
l1 : equ $-msg1
msg2 : db 'Enter second digit :'
l2 : equ $-msg2

section .bss
d1 : resb 1
d2 : resb 1
ans1 : resb 1
ans2 : resb 1
junk : resb 1

section .text

	global _start:
	_start:
	mov eax, 4							; For printing msg 1.
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	mov eax, 3							; To input the num1.
	mov ebx, 0
	mov ecx, d1
	mov edx, 1
	int 80h
	
	mov eax, 3							; We press enter for entering the num1. Nasm takes '\n' as input. 
	mov ebx, 0							; So to prevent this we are using just variable.
	mov ecx, junk
	mov edx, 1
	int 80h

	mov eax, 4							; For printing msg 2.
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h
	
	mov eax, 3							; To input num2.
	mov ebx, 0
	mov ecx, d2
	mov edx, 1
	int 80h
	
	mov eax, 3							; It is optional to add this.
	mov ebx, 0							; As this is the last time we are taking input it won't create any issue because '\n' will not be read.
	mov ecx, junk
	mov edx, 1
	int 80h

	sub byte[d1], 30h						; Converting to integer.
	sub byte[d2], 30h
	
	
	; ALERT THIS IS WRONG.
	; ; IMPORTANT LESSON: NEVER EVER TYPECAST A VARIABLE TO MORE NO OF BITS THAN IT IS INTIALIZED TO.(FOR EG: IF WE INITIALED A VARIABLE AS resw THEN NEVER TYPECAST IT INTO resd or resq. IF YOU 		; TRY TO DO THIS IT WILL THROW SOME GARBAGE VALUE.)
	; THE BELOW WRITTEN LINES ARE WRONG BECAUSE WE HAVE INITIALIZED d1 as byte AND WE ARE ACCESSING word from it(which have more bits than a bit so). SO THIS IS TOTALLY WRONG.
	mov ax, word[d1]				
	add ax, word[d2]					

	mov bl, 10
	mov ah, 0							; Clearing the higher 8 bits just in case if there are some values already present.(Always good practice to remove garbage)
	div bl

	mov byte[ans1], al
	mov byte[ans2], ah
	add byte[ans1], 30h
	add byte[ans2], 30h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans1
	mov edx, 1
	int 80h

	mov eax, 4
	mov ebx, 1
	mov ecx, ans2
	mov edx, 1
	int 80h

	mov eax, 1
	mov ebx, 0
	int 80h


















