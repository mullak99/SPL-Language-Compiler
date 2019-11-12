@echo off
flex spl.l
bison spl.y -v
gcc -o splc.exe spl.tab.c spl.c -lfl