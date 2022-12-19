section .data
msg1 : db 'Enter the size of array : '
l1 : equ $-msg1
msg2 : db 'Output : '
l2 : equ $-msg2
newl : db ' ', 10
nl : equ $-newl



section .bss

; Variables goes here.
b: resb 1
c: resw 1
n: resd 1
sum: resw 1
val: resd 1

; This are variables for printing purpose only.
num : resd 1
count: resb 1
temp: resb 1
zero: resb 1

section .text

	global _start:
	_start:

	mov eax, 4
	mov ebx, 1
	mov ecx, msg1
	mov edx, l1
	int 80h
	
	call read_num
	mov eax, dword[num]
	mov dword[n], eax
	
	mov word[sum],0
	
	Mylogic:
		call read_num
		mov eax, dword[num]
		call isPrime
		
		cmp byte[b], 1
		jne L
		add [sum],eax
		
		L:
		dec word[n]
		cmp word[n],0
		ja Mylogic
	
	
	mov eax, 4
	mov ebx, 1
	mov ecx, msg2
	mov edx, l2
	int 80h
	
	
	; IMPORTANT LESSON: NEVER EVER TYPECAST A VARIABLE TO MORE NO OF BITS THAN IT IS INTIALIZED TO.(FOR EG: IF WE INITIALED A VARIABLE AS resw THEN NEVER TYPECAST IT INTO resd or resq. IF YOU 		; TRY TO DO THIS IT WILL THROW SOME GARBAGE VALUE.)
	; IN CONTEXT OF THIS QUESTION IF WE TRY TO TYPECAST sum as dword THEN WE WILL GET SOME GARBAGE OUTPUT BECAUSE WE HAVE INITIAZED sum as resw.
	mov ax, word[sum]										
	mov [num], ax
	call print_num
	
	mov eax, 1
	mov ebx, 0
	int 80h



	;Writing the logic for isprime
	isPrime:
	pusha
	
	mov byte[b], 0	
	mov word[c], 2
	
	cmp word[num], 1
	je notprime
	
	for:
		mov bx, word[c]
		cmp bx,word[num]
		jnb prime
		
		mov bx, word[c]
		mov ax, word[num]
		mov dx, 0
		div bx
		
		cmp dx,0
		je notprime
		add word[c],1
		jmp for
		
	prime: 
		mov byte[b], 1
	
	notprime: 
	
	popa
	ret




	; Taking input.
	read_num:										
	pusha						
	
	mov dword[num], 0
	loop_read:
		; read a digit
		mov eax, 3
		mov ebx, 0
		mov ecx, temp
		mov edx, 1
		int 80h
	
		
		cmp byte[temp], 10							
		je end_read
	
		mov eax, dword[num]
		mov ebx, 10
		mul ebx
		mov ebx, dword[temp]
		sub ebx, 30h
	
		add eax, ebx
		mov [num], eax
		jmp loop_read
	
	end_read:
	popa											
	ret											
	
	
	
	
	;Printing an multiple digit number.
	print_num:									
	mov byte[count],0
	pusha
	
	cmp dword[num],0								
	je print_zero
	
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
	
	print_zero:
		mov byte[zero], 30h
		
		mov eax, 4
		mov ebx, 1
		mov ecx, zero
		mov edx, 1
		int 80h
		
	
	end_print:
		mov eax,4
		mov ebx,1
		mov ecx,newl
		mov edx,nl
		int 80h
		
		
	popa
	ret											
