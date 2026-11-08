@echo off
setlocal
title TaskMate - Push ke GitHub via Token
color 0b

set "GIT=%LOCALAPPDATA%\MinGit\cmd\git.exe"
if not exist "%GIT%" set "GIT=git"

echo ========================================================
echo        TASKMATE - PUSH KE GITHUB DENGAN TOKEN
echo ========================================================
echo Repository: https://github.com/enoqorisi24-source/PPL_ENO-QORI_SI24E.git
echo.

set "TOKEN=%~1"

if "%TOKEN%"=="" (
    echo Masukkan GitHub Personal Access Token (PAT) Anda:
    echo (Token diawali dengan ghp_... atau github_pat_...)
    echo.
    set /p "TOKEN=Token GitHub: "
)

if "%TOKEN%"=="" (
    echo Error: Token tidak boleh kosong!
    pause
    exit /b 1
)

echo.
echo [1/3] Menyetel remote origin dengan token autentikasi...
"%GIT%" remote remove origin 2>nul
"%GIT%" remote add origin https://%TOKEN%@github.com/enoqorisi24-source/PPL_ENO-QORI_SI24E.git

echo [2/3] Memastikan branch main...
"%GIT%" branch -M main

echo [3/3] Melakukan push ke GitHub...
"%GIT%" push -u origin main

echo.
if %ERRORLEVEL% equ 0 (
    echo ========================================================
    echo   BERHASIL! Seluruh proyek telah ter-push ke GitHub!
    echo ========================================================
    :: Bersihkan token dari remote config demi keamanan
    "%GIT%" remote set-url origin https://github.com/enoqorisi24-source/PPL_ENO-QORI_SI24E.git
) else (
    echo ========================================================
    echo   GAGAL PUSH! Periksa apakah token valid dan memiliki
    echo   izin (scope) centang 'repo'.
    echo ========================================================
)

pause
