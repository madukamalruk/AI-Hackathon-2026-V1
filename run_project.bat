@echo off
chcp 65001 >nul
set PYTHONIOENCODING=utf-8
title UniPath LK - Council of Walkers (Jac v0.16.7)

echo ==================================================================
echo   UniPath LK - Post-A/L Higher Education Pathway Navigator
echo   AI Hackathon 2026 Sri Lanka ^| Powered by Jac v0.16.7
echo ==================================================================
echo.

REM 1. Check if jac CLI is installed
where jac >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo [INFO] Jac Language not found. Installing jaclang==0.16.7 via pip...
    pip install -r requirements.txt
)

REM 2. Run CLI Verification Test
echo [1/3] Running Council of Walkers CLI Verification (jac run main.jac)...
echo.
jac run main.jac
echo.

REM 3. Open Frontend UI in default browser
echo [2/3] Launching Interactive Web UI (index.html)...
start "" "%~dp0index.html"

REM 4. Start Jac Backend REST Server on Port 8000
echo [3/3] Starting Jac Backend Server on http://localhost:8000 ...
echo       (Keep this window open while using the app. Press Ctrl+C to stop.)
echo.
jac start main.jac --port 8000
pause
