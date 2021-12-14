#!/bin/bash


#Author: Floyd Holliday
#Program name: Basic Float Operations

rm *.o
rm *.out

echo "This is program Assignment 6"

echo "Assemble the module sum.asm"
nasm -f elf64 -l sum.lis -o sum.o sum.asm

echo "Assemble the module clock_speed.asm"
nasm -f elf64 -l freq.lis -o clock_speed.o clock_speed.asm

echo "Compile the C module validation.c"
gcc -c -Wall -m64 -no-pie -l validation.lis -o validation.o validation.c -std=c11 #look up c version

echo "Compile the C module loops.c"
gcc -c -Wall -m64 -no-pie -o loops.o loops.c -std=c11 #look up c version

echo "Link the three object files already created"
gcc -m64 -no-pie -o wrongsum.out validation.o loops.o sum.o clock_speed.o -std=c11  #look up version

echo "Run the program Assignment 6"
./wrongsum.out

echo "The bash script file is now closing."
