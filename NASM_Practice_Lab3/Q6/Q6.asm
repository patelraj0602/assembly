section .data
msg1: db 'Enter details of first array: ', 10
l1: equ $-msg1
msg2: db 'Enter details of second array: ', 10
l2: equ $-msg2
msg3: db 'Enter number of elements: '
l3: equ $-msg3
msg4: db 'Enter a number: '
l4: equ $-msg4
msg5: db 'The common elements: '
l5: equ $-msg5
newline: db '', 10
space: db ' '

section .bss
d: resb 1
arr1: resd 50
arr2: resd 50
n1: resd 1
n2: resd 1
i: resd 1
j: resd 1
n: resd 1
counter: resb 1


section .text
    global _start:
    _start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h

    call read_num
    mov eax, dword[n]
    mov dword[n1], eax
    
    mov ebx, arr1
    call read_arr

    mov eax, 4
    mov ebx, 1
    mov ecx, msg2
    mov edx, l2
    int 80h
    
    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h

    call read_num
    mov eax, dword[n]
    mov dword[n2], eax

    mov ebx, arr2
    call read_arr

    mov eax, 4
    mov ebx, 1
    mov ecx, msg5
    mov edx, l5
    int 80h

    call find_common

    mov eax, 4
    mov ebx, 1
    mov ecx, newline
    mov edx, 1
    int 80h

    mov eax, 1
    mov ebx, 0
    int 80h



find_common:
    mov ebx, arr1
    mov edx, dword[n1]
    mov dword[i], edx
    loop_i:
        mov ecx, arr2
        mov edx, dword[n2]
        mov dword[j], edx
        loop_j:
            mov edx, dword[ebx]
            cmp edx, dword[ecx]
            jne next_check

            mov dword[n], edx
            call print_num

            next_check:
            add ecx, 4
            dec dword[j]
            jnz loop_j
        add ebx, 4
        dec dword[i]
        jnz loop_i

    ret

        


read_arr:
    mov dword[i], eax
    
    element_read_loop:    
        push ebx
        mov eax, 4
        mov ebx, 1
        mov ecx, msg4
        mov edx, l4
        int 80h
        pop ebx
        
        call read_num
        mov ecx, dword[n]
        mov dword[ebx], ecx
        
        add ebx, 4
        dec dword[i]
        jnz element_read_loop
    
    ret


read_num:

    pushad
    mov dword[n], 0

    read:  
        mov eax, 3
        mov ebx, 0
        mov ecx, d
        mov edx, 1
        int 80h

        cmp byte[d], 10
        je read_exit

        sub byte[d], 30h
        mov eax, dword[n]
        mov ebx, 10
        mul ebx
        mov ebx, 0
        add bl, byte[d]
        add eax, ebx
        mov dword[n], eax
        jmp read

    read_exit:        
        popad
        ret



print_num:
    
    pushad
    mov byte[counter], 0
    cmp dword[n], 0
    je zero

    extract:
        mov eax, dword[n]
        cmp eax, 0
        je print
        
        inc byte[counter]
        mov edx, 0
        mov ebx, 10
        div ebx
        push dx
        mov dword[n], eax
        jmp extract

    print:

        cmp byte[counter], 0
        je print_exit

        dec byte[counter]
        pop ax
        mov byte[d], al
        add byte[d], 30h

        mov eax, 4
        mov ebx, 1
        mov ecx, d
        mov edx, 1
        int 80h
        jmp print

    zero:
        mov byte[d], 30h
        mov eax, 4
        mov ebx, 1
        mov ecx, d
        mov edx, 1
        int 80h

    
    print_exit:
        mov eax, 4
        mov ebx, 1
        mov ecx, space
        mov edx, 1
        int 80h

        popad
        ret
