;****************************************************************************************************************************
;Program name: "Assignment 4".  This program greets a user by their inputted name  *
;and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
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
; Program name: Assignment 4
;  Programming languages X86 with one module in C and one module in C++
;  Date program began 2021-Nov-11
;  Date program completed 2021-Nov-14
;
;Purpose
;  This program takes the value of resistance and current and
;  returns the power computation if inputs are valid, otherwise
;  it tells user to try again
;Project information
;  Files: maxwell.c, hertz.asm, r.sh
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
global summation


segment .data
align 16
processor_mess db "The machine is running a cpu rated at GHz.", 10, 0
clock_time db "The time on the clock is now %ld tics.", 10, 0
sum_mess db "The sum has been computed.", 10, 0
sum_val db "The sum is .", 10, 0
promptname db "Please enter your name.  You choose the format of your name: ", 0
farewell_message db "Gabriel wishes you a Nice Day.", 10, 0
mess db "Invalid input detected.  You may run this program again", 10, 0
heightprompt db "Please enter the height in meters of the dropped marble: ", 0
curprompt db "Please enter the current flow in this circuit: ",0
marble_time db "The marble will reach the earth after %5.9lf seconds.", 10, 0
exec_time db "The execution time was %ld.", 10, 0
one_float_format db "%lf",0
stringform db "%s", 0
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

mov rax, 0                     ;A zero in rax means printf uses no data from xmm registers.
mov rdi, processor_mess        ;"The machine is running at a cpu rated at "
call printf



;===============================================================================================================
mov rax, 0
call validp        ;"Please enter the precision number... You entered"
                            ;where is value from valid_precision stored?

;find out where value returned from is stored
;get a negative one into an xmm register and use the cmp (or equivalent) and jne right after
;to handle invalid inputs. put condition being jumped into at beginning of loop

;this next block should occur after call to the other C file (not the driver)
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

mov rax, 0
mov rdi, sum_val
;mov rsi, 
call printf

;===========================================================================================================================================================

mov rax, 0
mov rdi, exec_time
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
