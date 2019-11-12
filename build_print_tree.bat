@echo off
flex spl.l
bison spl.y -v
gcc -o splc-tree.exe spl.tab.c spl.c -lfl -DDEBUG