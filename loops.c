//****************************************************************************************************************************
//Program name: "Assignment 6".  This program takes an inputted precision value from the user and  *
//computes the value 4 * -1 ^k / 2 *k + 1 from k = 0, incrementing k by 1 until
//that equation produces a positive value less than the precision value entered.
//Copyright (C) 2021  Gabriel Gamboa                                                                                 *
//This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License  *
//version 3 as published by the Free Software Foundation.                                                                    *
//This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied         *
//warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.     *
//A copy of the GNU General Public License v3 is available here:  <https://www.gnu.org/licenses/>.                           *
//****************************************************************************************************************************

// ;========1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3=========4=========5=========6=========7**
// ;Author information
// ;  Author name: Gabriel Gamboa
// ;  Author email: gabe04@csu.fullerton.edu
// ;
// ;Program information
// ; Program name: Assignment 6
// ;  Programming languages X86 with two modules in C
// ;  Date program began 2021-Dec-06
// ;  Date program completed 2021-Nov-14
// ;
// ;Purpose
// ;  This program takes an inputted precision value from the user and
// ;  computes the value 4 * -1 ^k / 2 *k + 1 from k = 0, incrementing k by 1 until
// ;  that equation produces a positive value less than the precision value entered.
// ;Project information
// ;  Files: sum.asm, clock_speed.asm, loops.c, validation.c, r.sh, rg.sh
// ;  Status: The program has been tested extensively with no detectable errors.
// ;
//This file
//   File name: loops.c
//   Language: C
//   Compile: gcc -c -Wall -m64 -no-pie -l validation.lis -o validation.o validation.c -std=c11
//   Link: gcc -m64 -no-pie -o wrongsum.out validation.o loops.o sum.o clock_speed.o -std=c11
//
//
// ;============================================================================================================================================================
//
//===== Begin code area ===========================================================================================================

#include <stdio.h>
#include <stdint.h>
#include <time.h>
#include <sys/time.h>
#include <stdlib.h>
#include <string.h>

extern double summation(); //why do i get an error when i include "C"? is it because I'm not compiling with g++?
int main(int argc, char* argv[])
{double answer = 0.0;
 printf("Welcome to this wonderful program written by Gabriel Gamboa planning a career in microprocessor architecture.\n");
 answer = summation();
 printf("The driver returned this number %8.5lf and has no knowledge about it.\n",answer);
 printf("Zero will be returned to the OS as a signal of success.\n");
 return 0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
