;****************************************************************************************************************************
;Program name: "Assignment 6".  This program takes an inputted precision value from the user and   *
;computes the value 4 * -1 ^k / 2 *k + 1 from k = 0, incrementing k by 1 until
;that equation produces a positive value less than the precision value entered.
;Copyright (C) 2021  Gabriel Gamboa                                                                                 *
;This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
;version 3 as published by the Free Software Foundation.                                                                    *
;This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
;warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
;A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
;****************************************************************************************************************************

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
;Author information
;  Author name: Gabriel Gamboa
;  Author email: gabe04@csu.fullerton.edu
;
;Program information
; Program name: Assignment 6
;  Programming languages X86 with two modules in C
;  Date program began 2021-Dec-06
;  Date program completed 2021-Dec-14
;
;Purpose
;  This program takes an inputted precision value from the user and
;  computes the value 4 * -1 ^k / 2 *k + 1 from k = 0, incrementing k by 1 until
;  that equation produces a positive value less than the precision value entered.
;Project information
;  Files: sum.asm, clock_speed.asm, loops.c, validation.c, r.sh, rg.sh
;  Status: The program has been tested extensively with no detectable errors.
;
;Translator information
;  Linux: nasm -f elf64 -l hertz.lis -o hertz.o hertz.asm


;============================================================================================================================================================


;===== Begin code area =============================================================================================================================
extern printf
extern scanf
extern fgets
extern strlen
extern stdin
extern atof
extern validp
extern clock_speed
global summation


segment .data
align 16
processor_mess db "The machine is running a cpu rated at %5.2lf GHz.", 10, 0
clock_time db "The time on the clock is now %ld tics.", 10, 0
sum_mess db "The sum has been computed.", 10, 0
sum_val db "The sum is %5.9lf.", 10, 0
precision_test db "The precision in the asm file is %5.9lf ", 10, 0
exec_time db "The execution time was %ld tics.", 10, 0

align 64
segment .bss  ;Reserved for uninitialized data

programmers_name resb 256                  ;256 byte space created
height_string resb 256                        ;256 byte space created
cur_string resb 256                        ;256 byte space created

segment .text ;Reserved for executing instructions.

summation:

;=============================================================================================
;back up data in registers
push rbp
mov  rbp,rsp
push rdi                                                    ;Backup rdi
push rsi                                                    ;Backup rsi
push rdx                                                    ;Backup rdx
push rcx                                                    ;Backup rcx
push r8                                                     ;Backup r8
push r9                                                     ;Backup r9
push r10                                                    ;Backup r10
push r11                                                    ;Backup r11
push r12                                                    ;Backup r12
push r13                                                    ;Backup r13
push r14                                                    ;Backup r14
push r15                                                    ;Backup r15
push rbx                                                    ;Backup rbx
pushf                                                       ;Backup rflags



;get info about processor in bloack before calling processor_mess
;========================================================================================
;call clock_speed program to get info

mov rax, 0
call clock_speed
movsd xmm15, xmm0

mov rax, 1                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, processor_mess        ;"The machine is running at a cpu rated at "
movsd xmm0, xmm15
call printf



;===============================================================================================================
tryagain:
mov rax, 0
call validp         ;"Please enter the precision number... You entered"
movsd xmm15, xmm0   ;value returned from function is

;create -1.0 to compare with invalid inputs
push qword -1            ;push qword onto stack so we can convert it to float format to use in our calculations
cvtsi2sd xmm14, [rsp]   ;convert -1 to -1.0 and store it in xmm14
pop rax

;ucomisd is floating point version of cmp command
ucomisd xmm14, xmm15        ;instruction for comparing xmm registers.
je tryagain

mov rax, 1
mov rdi, precision_test
movsd xmm0, xmm15
call printf


;this next block should occur after call to C file recieving and validating input
;======Get clock time ========================================================================================================================


mov rax, 0
mov rdx, 0

cpuid                              ; Identifies the type of cpu being used on pc.
rdtsc                              ; Counts the number of cycles/tics occured since pc reset.

shl rdx, 32
add rax, rdx
mov r14, rax



;====================================================================================================================================================

mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, clock_time               ;"The time on the clock is now tics"
mov rsi, r14
call printf

;===Do arithmetic here=======================================================================================================================================


;initialize xmm11 with value of 0
push qword 0
cvtsi2sd xmm11, [rsp]
pop rax

;initialize xmm14 with value of 0
push qword 0
cvtsi2sd xmm14, [rsp]       ;set xmm14 equal to zero for initial addition of xmm14 and xmm11 in loop
pop rax

;initialize xmm14 with value of 0
push qword 0
cvtsi2sd xmm7, [rsp]       ;set xmm7 equal to zero for comparison with value to be added to sum
pop rax                    ;and not breaking out of the loop if value is negative


;initialize r13 to 1 as a  psuedo counter k
;initialize r12 to 0 as actual counter  (having 2 simplifies a loop i made)
mov r13, 1
mov r12, 0

;start formula loop point here
calc_sum:
calc:

;create -1.0 to compare with invalid inputs
push qword -1
cvtsi2sd xmm14, [rsp]
pop rax

;create 4.0 to compare with invalid inputs
push qword 4
cvtsi2sd xmm13, [rsp]
pop rax

;create 2.0 to compare with invalid inputs
push qword 2
cvtsi2sd xmm12, [rsp]
pop rax

;create -1.0 to compare with invalid inputs
push qword -1
cvtsi2sd xmm9, [rsp]
pop rax

;begin loop to multiply -1 by itself until we get -1^k (it will be off by 1 multiple)

;even though we start with k = 1, it works out because we are supposed to start at 0 so offset is fixed
power:
sub r13, 1
mulsd xmm14, xmm9       ;multiplying xmm14 by itself won't go back to neg after first multiply
cmp r13, 0
ja power

;-1^k is now in xmm14
;multiply 4 * -1 ^k / 2 *k + 1   (multiply)

;store value of "k" in xmm8 to use in denominator of formula
cvtsi2sd xmm8, r12

;start arithmetic
mulsd xmm14, xmm13     ;4 * -1^k stored in xmm14 (numerator)
mulsd xmm12, xmm8      ;2 * k stored in xmm12

push qword 1            ;push qword onto stack so we can convert it to float format to use in our calculations
cvtsi2sd xmm10, [rsp]   ;convert 1 to 1.0 and store it in xmm10
pop rax

addsd xmm12, xmm10      ;2 * k + 1 stored in xmm12 (denominator)
divsd xmm14, xmm12      ;value to be added to sum now stored in xmm14


;restore value of r13
mov r13, r12
add r13, 1            ;increment our psuedo counter by 2 (pseudo counter is 1 greater than backup counter, + our normal increment = 2)
add r13, 1            ;increment our psuedo counter by 2
add r12, 1            ;increment our backup counter by 1

;add value to sum
addsd xmm11, xmm14          ;store value of sum in xmm11

;compare xmm14 with zero to deal with next number being negative (we exit when positive value being added is less than precision)
ucomisd xmm14, xmm7     ;compare value to be added with zero and continue loop if value is negative
jb calc

;compare xmm14 with precision value (xmm15). If xmm14 < xmm15, stop adding sum and break out of loop
ucomisd xmm14, xmm15     ;compare calue to be added to sum with precision
jae calc_sum            ;if <op1> >= <op2>, keep on adding formula to sum (xmm11) ;jae is for xmm, jge is for r registers
                        ;now we need to take care of checking whether r12 (k) is even, and jumping to calc_sum if it is
                        ;or we can compare the next value to be added with zero, if it's less than zero we continue in our loop

;after loop ends, store sum of formula in xmm14
movsd xmm14, xmm11


;=========================================================================================================================================================

mov rax, 0
mov rdi, sum_mess             ;"The sum has been computed"
call printf

;======Get clock time ========================================================================================================================


mov rax, 0
mov rdx, 0

cpuid                              ; Identifies the type of cpu being used on pc.
rdtsc                              ; Counts the number of cycles/tics occured since pc reset.

shl rdx, 32
add rax, rdx
mov r15, rax                      ;store rax into safe register r15 and pass that value into clock_time printf



;====================================================================================================================================================

mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, clock_time               ;"The time on the clock is now tics"
mov rsi, r15
call printf


;=========================================================================================================================================================

mov rax, 1
mov rdi, sum_val        ;"The sum is %5.9lf.", 10, 0
movsd xmm0, xmm14
call printf

;===========================================================================================================================================================

mov rax, 0
mov rdi, exec_time        ;"The execution time was %ld tics."
sub r15, r14
mov rsi, r15
call printf


;is next block needed?
;============================================================================================================

continue:                     ;invalid input jumps to this part
movsd xmm0, xmm14              ;power return to caller.

;=================================================================================================================


;===== Restore backed up registers ===============================================================================
popf                                                        ;Restore rflags
pop rbx                                                     ;Restore rbx
pop r15                                                     ;Restore r15
pop r14                                                     ;Restore r14
pop r13                                                     ;Restore r13
pop r12                                                     ;Restore r12
pop r11                                                     ;Restore r11
pop r10                                                     ;Restore r10
pop r9                                                      ;Restore r9
pop r8                                                      ;Restore r8
pop rcx                                                     ;Restore rcx
pop rdx                                                     ;Restore rdx
pop rsi                                                     ;Restore rsi
pop rdi                                                     ;Restore rdi
pop rbp                                                     ;Restore rbp

ret

;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
