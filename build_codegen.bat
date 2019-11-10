@echo off
flex spl.l
bison spl.y -v
gcc -o codegen.exe spl.tab.c spl.c -lfl