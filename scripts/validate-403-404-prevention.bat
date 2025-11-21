@echo off
REM Simple batch wrapper for PowerShell validation script
REM Usage: validate-403-404-prevention.bat

powershell.exe -ExecutionPolicy Bypass -File "%~dp0validate-403-404-prevention.ps1" %*

if %ERRORLEVEL% EQU 0 (
    echo.
    echo Validation completed successfully.
    exit /b 0
) else (
    echo.
    echo Validation failed. Please review the issues above.
    exit /b 1
)

