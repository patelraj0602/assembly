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

section .text
	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h

	call read_string
	
    	mov eax, 4
	mov ebx, 1
	mov ecx, array
	mov edx, len
	int 80h
	
	mov dword[l],0
	mov eax, dword[len]
	mov dword[h], eax
    	sub dword[h], 1

	looping:
		mov al, byte[h]
		mov bl, byte[l]
		cmp al,bl
		jb palindrome
		
		mov eax, array
		add eax, dword[l]
        mov cl, byte[eax]
        mov [low], cl
		
		mov ebx, array
		add ebx, dword[h]
        mov dl, byte[ebx]
        mov [high], dl

    
        mov ax, word[low]
        mov bx, word[high]
		cmp ax,bx
		jne notpalindrome
		
		add byte[l],1
		sub byte[h],1
        jmp looping
	
	palindrome:
		mov byte[ans],1
		jmp exiting
	
	notpalindrome:
		mov byte[ans],0
	
	exiting:
	
        add byte[ans],30h
		mov eax, 4
		mov ebx, 1
		mov ecx, ans
		mov edx, 1
		int 80h
		
		mov eax, 4
		mov ebx, 1
		mov ecx, newl
		mov edx, nl
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
