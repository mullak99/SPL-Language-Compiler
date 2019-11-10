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

#### Building a Printing Lexer

```
flex spl.l
gcc -o lexer.exe -DPRINT lex.yy.c -lfl
```

#### Building a Parser

```
flex spl.l
bison spl.y -v
gcc -o parser.exe spl.tab.c spl.c -lfl
```
(Or run 'build_parser.bat')

### Building a Parser (in Debug Mode)

```
flex spl.l
bison spl.y -v
gcc -o parserDebug.exe spl.tab.c spl.c -lfl -DYYDEBUG
```
(Or run 'build_parser_debug.bat')

### Building a Parse Tree

```
flex spl.l
bison spl.y -v
gcc -o tree.exe spl.tab.c spl.c -lfl -DDEBUG
```
(Or run 'build_print_tree.bat')