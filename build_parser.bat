@echo off
flex spl.l
bison spl.y -v
gcc -o splc-parser.exe -DYYDEBUG -UYY_MAIN spl.c spl.tab.c -lfl