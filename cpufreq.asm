extern printf
extern atof

global cpufreq

;initialized data goes here
segment .data
    ;nothing goes here

;unintialized data goes here
segment .bss
    ;nothing goes here

section .text
    cpufreq:
        ;push the registers
        push rbp
        mov rbp, rsp
        push rbx
        push rcx
        push rdx
        push rdi
        push rsi
        push r8
        push r9
        push r10
        push r11
        push r12
        push r13
        push r14
        push r15
        pushf

        mov r14, 0x80000003 ; this value is passed to cpuid to get information about the processor

        ;clear r15 and r11
        xor r15, r15  ;will be used as control var in string_loop
        xor r11, r11  ;will be used as the counter/flag in char_loop

        string_loop:
            ;clear the r13
            xor r13, r13

            mov rax, r14  ;get cpu info
            cpuid
            inc r14       ;inc cpu info

            ;push 4 registers for 4 sets of chars
            push rdx
            push rcx
            push rbx
            push rax


        register_loop:
            ;clear r12
            xor r12, r12

            ;receive 4 char string
            pop rbx

        char_loop:
            mov rdx, rbx  ;move string of 4 chars (rbx) to rdx
            and rdx, 0xFF ;get first char in string
            shr rbx, 0x8  ;shift right to get next char in iteration

            cmp rdx, 64   ;@ sign

            jne counter   ;leaves r11, no flag
            mov r11, 1    ;flag/counter to start storing chars in r10

        counter:
            cmp r11, 1    ;checks if flag is true
            jl main       ;skips increment and jump to main if flag is false
            inc r11       ;inc r11 by 1 if flag is true

        main:
            cmp r11, 4    ;if counter is greater than 4, jump to loop_cond
            jl loop_cond

            cmp r11, 7    ;if counter is less than 7, jump to loop_cond
            jg loop_cond

            shr r10, 0x8  ;r10 is the queue for chars
            shl rdx, 0x18 ;shift left to get free space for r10
            or r10, rdx   ;combine the registers

        loop_cond:
            inc r12
            cmp r12, 4 ;if r12 is 4, go to char loop
            jne char_loop

            inc r13
            cmp r13, 4 ;if r13 is 4, go to register loop
            jne register_loop

            inc r15
            cmp r15, 2 ;if r15 is 2, go to string loop
            jne string_loop

        quit:
            push r10
            ;clear rax
            xor rax, rax

            mov rdi, rsp
            call atof  ;converts the string to float

            pop r10    ;returning xmm0

        ;pop the registers
        popf
        pop r15
        pop r14
        pop r13
        pop r12
        pop r11
        pop r10
        pop r9
        pop r8
        pop rsi
        pop rdi
        pop rdx
        pop rcx
        pop rbx
        pop rbp

ret  ;program done
