@echo off
flex spl.l
bison spl.y -v
gcc -o parserDebug.exe spl.tab.c spl.c -lfl -DYYDEBUG