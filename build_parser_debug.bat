flex spl.l
bison spl.y -v
gcc -o parser.exe spl.tab.c spl.c -lfl -DYYDEBUG