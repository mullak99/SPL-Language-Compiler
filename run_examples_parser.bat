@echo off
call build_parser.bat
rmdir /s /q tests\parser-debug-output 2>nul
md tests\parser-debug-output
splc-parser.exe < examples\a.spl 2> tests\parser-debug-output\a.spl-parser.txt
splc-parser.exe < examples\b.spl 2> tests\parser-debug-output\b.spl-parser.txt
splc-parser.exe < examples\c.spl 2> tests\parser-debug-output\c.spl-parser.txt
splc-parser.exe < examples\d.spl 2> tests\parser-debug-output\d.spl-parser.txt
splc-parser.exe < examples\e.spl 2> tests\parser-debug-output\e.spl-parser.txt