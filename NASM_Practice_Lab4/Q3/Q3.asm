section .data
msg1 : db 'Enter first string : '
l1 : equ $-msg1
msg2 : db 'Enter second string : '
l2 : equ $-msg2
newl : db ' ', 10
nl : equ $-newl

section .bss
array : resb 100
concat: resb 200
char : resd 1
len : resd 1
now: resd 1
cur: resd 1

section .data
	global _start:
	_start:

	mov dword[cur],0

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_string
    call concatination

	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h

	call read_string
    call concatination

    mov eax, 4
	mov ebx, 1
	mov ecx, concat
	mov edx, cur
	int 80h
	
    mov eax, 1
	mov ebx, 0
    int 80h



	concatination:
    pusha
    mov dword[now],0
    looping:
		mov al, byte[now]
        cmp al, byte[len]
		jnb exiting

		mov eax, array
		add eax, dword[now]
        mov cl, byte[eax]

        mov eax, concat
        add eax, dword[cur]
        mov byte[eax], cl
		
        add dword[cur], 1
		add dword[now], 1
        jmp looping

	exiting:
    popa
    ret


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
