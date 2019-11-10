@echo off
call build_parser.bat
rmdir /s /q tests\parser-debug-output 2>nul
md tests\parser-debug-output
parser.exe < examples\a.spl > tests\parser-debug-output\a.spl-parser.txt
parser.exe < examples\b.spl > tests\parser-debug-output\b.spl-parser.txt
parser.exe < examples\c.spl > tests\parser-debug-output\c.spl-parser.txt
parser.exe < examples\d.spl > tests\parser-debug-output\d.spl-parser.txt
parser.exe < examples\e.spl > tests\parser-debug-output\e.spl-parser.txt