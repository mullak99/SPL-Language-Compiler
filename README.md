# SPL Language Compiler (SPLC)

SPL Compiler by mullak99

## How to use

This project is currently a WIP.

### Requirements
- GCC
- Lex/Flex
- Yacc/Bison

### How to compile (Flex/Bison):

Tested on Windows 10 x86_64 (MSYS2)

```
flex spl.l
gcc -o test.exe -DPRINT lex.yy.c -lfl
test.exe
```
