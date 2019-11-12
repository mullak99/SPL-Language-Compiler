@echo off
call build_printing_lexer.bat
rmdir /s /q tests\printinglexer-debug-output 2>nul
md tests\printinglexer-debug-output
splc-lexer.exe < examples\a.spl > tests\printinglexer-debug-output\a.spl-printinglexer.txt
splc-lexer.exe < examples\b.spl > tests\printinglexer-debug-output\b.spl-printinglexer.txt
splc-lexer.exe < examples\c.spl > tests\printinglexer-debug-output\c.spl-printinglexer.txt
splc-lexer.exe < examples\d.spl > tests\printinglexer-debug-output\d.spl-printinglexer.txt
splc-lexer.exe < examples\e.spl > tests\printinglexer-debug-output\e.spl-printinglexer.txt