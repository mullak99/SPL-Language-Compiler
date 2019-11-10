@echo off
call build_parser_debug.bat
rmdir /s /q tests\parserdebugmode-debug-output 2>nul
md tests\parserdebugmode-debug-output
parserDebug.exe < examples\a.spl > tests\parserdebugmode-debug-output\a.spl-parserdebugmode.txt
parserDebug.exe < examples\b.spl > tests\parserdebugmode-debug-output\b.spl-parserdebugmode.txt
parserDebug.exe < examples\c.spl > tests\parserdebugmode-debug-output\c.spl-parserdebugmode.txt
parserDebug.exe < examples\d.spl > tests\parserdebugmode-debug-output\d.spl-parserdebugmode.txt
parserDebug.exe < examples\e.spl > tests\parserdebugmode-debug-output\e.spl-parserdebugmode.txt