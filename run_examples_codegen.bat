@echo off
call build_codegen.bat
rmdir /s /q tests\codegen-debug-output 2>nul
md tests\codegen-debug-output
codegen.exe < examples\a.spl > tests\codegen-debug-output\a.spl-codegen.c
codegen.exe < examples\b.spl > tests\codegen-debug-output\b.spl-codegen.c
codegen.exe < examples\c.spl > tests\codegen-debug-output\c.spl-codegen.c
codegen.exe < examples\d.spl > tests\codegen-debug-output\d.spl-codegen.c
codegen.exe < examples\e.spl > tests\codegen-debug-output\e.spl-codegen.c

gcc -o tests\codegen-debug-output\a.exe tests\codegen-debug-output\a.spl-codegen.c
gcc -o tests\codegen-debug-output\b.exe tests\codegen-debug-output\b.spl-codegen.c
gcc -o tests\codegen-debug-output\c.exe tests\codegen-debug-output\c.spl-codegen.c
gcc -o tests\codegen-debug-output\d.exe tests\codegen-debug-output\d.spl-codegen.c
gcc -o tests\codegen-debug-output\e.exe tests\codegen-debug-output\e.spl-codegen.c

IF EXIST tests\codegen-debug-output\a.exe. (
	echo - a.exe -
	echo.
	cmd.exe /c "tests\codegen-debug-output\a.exe"
	echo.
)

IF EXIST tests\codegen-debug-output\b.exe. (
	echo - b.exe -
	echo.
	cmd.exe /c "tests\codegen-debug-output\b.exe"
	echo.
)

IF EXIST tests\codegen-debug-output\c.exe. (
	echo - c.exe -
	echo.
	cmd.exe /c "tests\codegen-debug-output\c.exe"
	echo.
)

IF EXIST tests\codegen-debug-output\d.exe. (
	echo - d.exe -
	echo.
	cmd.exe /c "tests\codegen-debug-output\d.exe"
	echo.
)

IF EXIST tests\codegen-debug-output\e.exe. (
	echo - e.exe -
	echo.
	cmd.exe /c "tests\codegen-debug-output\e.exe"
	echo.
)