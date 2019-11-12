@echo off
rmdir /s /q tests\codegen-debug-output 2>nul
rmdir /s /q tests\parser-debug-output 2>nul
rmdir /s /q tests\parsetree-debug-output 2>nul
rmdir /s /q tests\printinglexer-debug-output 2>nul
for /f "delims=" %%F in ('dir  /b /s  *.exe') do (del %%F)
for /f "delims=" %%F in ('dir  /b /s  *.output') do (del %%F)
for /f "delims=" %%F in ('dir  /b /s  *.stackdump') do (del %%F)