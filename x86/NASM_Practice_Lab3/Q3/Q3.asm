; Enter two digit numbers to an array of length 'n',
; a) identify the number which is having highest occurrence
; b) identify the number which is having lowest occurrence

section .data
msg1: db 'Enter the number of elements: '
l1: equ $-msg1
msg2: db 'Enter a number: '
l2: equ $-msg2
msg3: db 'Element with highest frequency: '
l3: equ $-msg3
msg4: db 'Element with lowest frequency: '
l4: equ $-msg4
newline: db '', 10


section .bss
d: resd 1
arr: resd 50
n: resd 1
i: resd 1
j: resd 1
max: resd 1
min: resd 1
max_val: resd 1
min_val: resd 1
curr: resd 1
n1: resd 1
counter: resb 1

section .text
    global _start:
    _start:

    mov eax, 4
    mov ebx, 1
    mov ecx, msg1
    mov edx, l1
    int 80h

    call read_num
    mov eax, dword[n1]
    mov dword[n], eax
 
    mov ebx, arr
    call read_arr

    mov eax, dword[n]
    mov ebx, arr
    call solve


    mov eax, 4
    mov ebx, 1
    mov ecx, msg3
    mov edx, l3
    int 80h
    
    mov eax, dword[max_val]
    mov dword[n1], eax
    call print_num

    mov eax, 4
    mov ebx, 1
    mov ecx, msg4
    mov edx, l4
    int 80h
    
    mov eax, dword[min_val]
    mov dword[n1], eax
    call print_num

    mov eax, 1
    mov ebx, 0
    int 80h





solve:

    mov dword[i], eax
    mov dword[min], eax 
    mov dword[max], 0
    mov eax, dword[ebx]
    mov dword[min_val], eax
    mov dword[max_val], eax

    loop_i:
        cmp dword[i], 0
        je loop_i_exit

        dec dword[i]

        mov eax, dword[n]
        mov dword[j], eax
        mov ecx, arr
        mov dword[curr], 0

        loop_j:
            cmp dword[j], 0
            je loop_j_exit
            dec dword[j]

            mov eax, dword[ecx]
            add ecx, 4
            cmp dword[ebx], eax
            jne loop_j 
            inc dword[curr]
            jmp loop_j

        loop_j_exit:
            mov eax, dword[max]
            cmp dword[curr], eax
            jna label1
            mov eax, dword[curr]
            mov dword[max], eax
            mov eax, dword[ebx]
            mov dword[max_val], eax

            label1:
            mov eax, dword[min]
            cmp dword[curr], eax
            jae label2
            mov eax, dword[curr]
            mov dword[min], eax
            mov eax, dword[ebx]
            mov dword[min_val], eax

            label2:
            add ebx, 4
            jmp loop_i

    loop_i_exit:
        ret




read_arr:
    mov dword[i], eax
    
    element_read_loop:
        push ebx
        mov eax, 4
        mov ebx, 1
        mov ecx, msg2
        mov edx, l2
        int 80h
        pop ebx
    
        call read_num
        mov ecx, dword[n1]
        mov dword[ebx], ecx
    
        add ebx, 4
        dec dword[i]
        jnz element_read_loop
    
    ret



read_num:

    pushad
    mov dword[n1], 0
    
    read:  
        mov eax, 3
        mov ebx, 0
        mov ecx, d
        mov edx, 1
        int 80h

        cmp byte[d], 10
        je read_exit

        sub byte[d], 30h
        mov eax, dword[n1]
        mov ebx, 10
        mul ebx
        mov ebx, 0
        add bl, byte[d]
        add eax, ebx
        mov dword[n1], eax
        jmp read

    read_exit:        
        popad
        ret



print_num:
    
    pushad
    mov byte[counter], 0
    cmp dword[n1], 0
    je zero

    extract:
        mov eax, dword[n1]
        cmp eax, 0
        je print
        
        inc byte[counter]
        mov edx, 0
        mov ebx, 10
        div ebx
        push dx
        mov dword[n1], eax
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
        mov ecx, newline
        mov edx, 1
        int 80h

        popad
        ret
