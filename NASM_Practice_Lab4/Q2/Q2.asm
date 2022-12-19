section .data
msg1 : db 'Enter the string : '
l1 : equ $-msg1
newl : db ' ', 10
nl : equ $-newl

section .bss
array : resb 100
char : resd 1
len : resd 1
l : resd 1
h : resd 1
low: resd 1
high: resd 1
ans : resd 1
temp: resb 1

section .data
	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_string
	
	mov dword[l],0
	mov eax, dword[len]
	mov dword[h], eax
    sub dword[h], 1

	looping:
		mov al, byte[h]
		mov bl, byte[l]
		cmp al,bl
		jb exiting
		
		mov eax, array
		add eax, dword[l]

		mov ebx, array
		add ebx, dword[h]
        
        mov cl, byte[eax]
        mov dl, byte[ebx]
        mov byte[eax], dl
        mov byte[ebx], cl
		
		add byte[l],1
		sub byte[h],1
        jmp looping

	exiting:

		mov eax, 4
		mov ebx, 1
		mov ecx, array
		mov edx, len
		int 80h
	
    mov eax, 1
	mov ebx, 0
    int 80h

	read_string:
	pusha

	mov dword[len],0
	loop_read:
		mov eax, 3
		mov ebx, 0
		mov ecx, char
		mov edx, 1
		int 80h
		
		cmp byte[char],10
		je end_read	
		
		mov ebx, array
		add ebx, dword[len]
        mov al, byte[char]
		mov byte[ebx], al
		
		add byte[len],1
		jmp loop_read
	end_read:
	popa
	ret
