//****************************************************************************************************************************
//Program name: "Assignment 4".  This program greets a user by their inputted name  *
//and title.  Copyright (C) 2021  Gabriel Gamboa                                                                                 *
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
// ; Program name: Assignment 4
// ;  Programming languages X86 with one module in C and one module in C++
// ;  Date program began 2021-Nov-11
// ;  Date program completed 2021-Nov-14
// ;
// ;Purpose
// ;  This program takes the value of resistance and current and
// ;  returns the power computation if inputs are valid, otherwise
// ;  it tells user to try again
// ;Project information
// ;  Files: maxwell.c, hertz.asm, r.sh
// ;  Status: The program has been tested extensively with no detectable errors.
// ;
//This file
//   File name: maxwell.c
//   Language: C
//   Compile: g++ -c -Wall -m64 -no-pie -o maxwell.o maxwell.c -std=c++17 #look up c version
//   Link: g++ -m64 -no-pie -o power.out isfloat.o maxwell.o hertz.o -std=c++17
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
#include <stdbool.h>
#include <ctype.h>



extern double validp();
double validp()
{
 bool result = true;                 // Assume floating number until proven otherwise.
 bool found = false;                 // Checks if only 1 decimal is entered.
 int start = 0;
 char w[30];
 double precision = 0.0;
 printf("Please enter the precision number and press enter: ");
 scanf("%s", w);
 if (w[0] == '+') start = 1;         // Checks to see if a valid plus sign is entered and
 unsigned long int k = start;        // increments the starting index for loop.
 while( !(w[k]=='\0') && result )
 {
     // Checks for decimal character in string with only 1 occurence.
     if ((w[k] == '.') && !found) { found = true;
     }
     else {
         // Sets result to true only if character at index k is a digit.
         result = result && isdigit(w[k]);
     }
     k++;
 }
 if(result && found){
   precision = atof(w);
   printf("You entered %5.10lf which will be returned to the caller function \n", precision); //why is different number displayed in sample output?
   return precision;
 }
 else{
   printf("Invalid input encountered. Please try again. \n");
 }
 return -1.0;
}
//=======1=========2=========3=========4=========5=========6=========7=========8=========9=========0=========1=========2=========3**
