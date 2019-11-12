@echo off
flex spl.l
gcc -o splc-lexer.exe -DPRINT lex.yy.c -lfl