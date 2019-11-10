@echo off
call build_codegen.bat
rmdir /s /q tests\codegen-debug-output 2>nul
md tests\codegen-debug-output
codegen.exe < examples\a.spl > tests\codegen-debug-output\a.spl-codegen.txt
codegen.exe < examples\b.spl > tests\codegen-debug-output\b.spl-codegen.txt
codegen.exe < examples\c.spl > tests\codegen-debug-output\c.spl-codegen.txt
codegen.exe < examples\d.spl > tests\codegen-debug-output\d.spl-codegen.txt
codegen.exe < examples\e.spl > tests\codegen-debug-output\e.spl-codegen.txt