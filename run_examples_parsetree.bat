@echo off
call build_print_tree.bat
rmdir /s /q tests\parsetree-debug-output 2>nul
md tests\parsetree-debug-output
splc-tree.exe < examples\a.spl > tests\parsetree-debug-output\a.spl-parsetree.txt
splc-tree.exe < examples\b.spl > tests\parsetree-debug-output\b.spl-parsetree.txt
splc-tree.exe < examples\c.spl > tests\parsetree-debug-output\c.spl-parsetree.txt
splc-tree.exe < examples\d.spl > tests\parsetree-debug-output\d.spl-parsetree.txt
splc-tree.exe < examples\e.spl > tests\parsetree-debug-output\e.spl-parsetree.txt