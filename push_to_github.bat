@echo off
setlocal
title TaskMate - Push ke GitHub
color 0a

set "GIT=%LOCALAPPDATA%\MinGit\cmd\git.exe"
if not exist "%GIT%" set "GIT=git"

echo ========================================================
echo        TASKMATE - PUSH REPOSITORY KE GITHUB
echo ========================================================
echo.

set "REPO_URL=%~1"

if "%REPO_URL%"=="" (
    echo Masukkan URL Repository GitHub Anda:
    echo Contoh: https://github.com/username/taskmate.git
    echo.
    set /p "REPO_URL=URL Repository: "
)

if "%REPO_URL%"=="" (
    echo URL tidak boleh kosong!
    pause
    exit /b 1
)

echo.
echo [1/3] Menghubungkan remote origin ke %REPO_URL%...
"%GIT%" remote remove origin 2>nul
"%GIT%" remote add origin %REPO_URL%

echo [2/3] Memastikan branch berada di main...
"%GIT%" branch -M main

echo [3/3] Melakukan git push ke GitHub...
"%GIT%" push -u origin main

echo.
if %ERRORLEVEL% equ 0 (
    echo ========================================================
    echo   BERHASIL! Proyek TaskMate telah ter-push ke GitHub!
    echo ========================================================
) else (
    echo Gagal melakukan push. Pastikan URL benar dan Anda telah login / memasukkan token GitHub.
)

pause
