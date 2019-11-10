@echo off
call build_printing_lexer.bat
rmdir /s /q tests\printinglexer-debug-output 2>nul
md tests\printinglexer-debug-output
lexer.exe < examples\a.spl > tests\printinglexer-debug-output\a.spl-printinglexer.txt
lexer.exe < examples\b.spl > tests\printinglexer-debug-output\b.spl-printinglexer.txt
lexer.exe < examples\c.spl > tests\printinglexer-debug-output\c.spl-printinglexer.txt
lexer.exe < examples\d.spl > tests\printinglexer-debug-output\d.spl-printinglexer.txt
lexer.exe < examples\e.spl > tests\printinglexer-debug-output\e.spl-printinglexer.txt