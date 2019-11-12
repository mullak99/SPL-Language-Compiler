# SPL Language Compiler (SPLC)

SPL Compiler by mullak99

## How to use

This project is currently a WIP.

### Requirements
- GCC
- Lex/Flex
- Yacc/Bison

## How to compile (Flex/Bison):

Tested on Windows 10 x86_64 (MSYS2)

### Building a Printing Lexer

```
flex spl.l
gcc -o splc-lexer.exe -DPRINT lex.yy.c -lfl
```
(Or run 'build_printing_lexer.bat')

### Building a Parser

```
flex spl.l
bison spl.y
gcc -o splc-parser.exe -DYYDEBUG -UYY_MAIN spl.c spl.tab.c -lfl
```
(Or run 'build_parser.bat')


### Building a Parse Tree

```
flex spl.l
bison spl.y
gcc -o splc-tree.exe spl.tab.c spl.c -lfl -DDEBUG
```
(Or run 'build_print_tree.bat')

### Building a Code Generator

```
flex spl.l
bison spl.y
gcc -o splc.exe spl.tab.c spl.c -lfl
```
(Or run 'build_codegen.bat')

## How to run tests (Flex/Bison on Windows):

Running tests will automatically create a 'tests' directory, with a subdirectory
for each test containing the output of each example file (a-e.spl).

### Testing a Printing Lexer

```
run_examples_printinglexer.bat
```

### Testing a Parser

```
run_examples_parser.bat
```

### Testing a Parse Tree

```
run_examples_parsetree.bat
```

### Testing a Code Generator

```
run_examples_codegen.bat
```

### Testing all of the above

```
run_examples_all.bat
```