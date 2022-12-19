section .data
msg1: db "Input string: ", 10
size1: equ $-msg1
section .bss
temp: resb 1
str1 : resb 50
space_cnt: resb 1
section .text
global _start:
_start:

mov eax,4
mov ebx,1
mov ecx,msg1
mov edx,size1
int 80h

mov ebx,str1

read_char:
push ebx
mov eax ,3
mov ebx,0
mov ecx,temp
mov edx,1
int 80h
pop ebx
mov al,byte[temp]
mov byte[ebx],al
inc ebx
cmp al,10
jne read_char

mov ebx,str1
mov al,0
mov byte[space_cnt],al

counting:
mov al,byte[ebx]
cmp al,10
je end
inc ebx
cmp al,32
je inc_cnt
jmp counting


inc_cnt:
inc byte[space_cnt]
jmp counting



end:
add byte[space_cnt],30h
mov eax,4
mov ebx,1
mov ecx,space_cnt
mov edx,1
int 80h
mov eax,1
mov ebx,0
int 80h
