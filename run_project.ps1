# UniPath LK — One-Click PowerShell Launcher
$OutputEncoding = [System.Text.Encoding]::UTF8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$env:PYTHONIOENCODING = "utf-8"

Write-Host "==================================================================" -ForegroundColor Cyan
Write-Host "  UniPath LK — Council of Walkers (Jac v0.16.7)" -ForegroundColor Emerald
Write-Host "==================================================================" -ForegroundColor Cyan

if (-not (Get-Command "jac" -ErrorAction SilentlyContinue)) {
    Write-Host "[INFO] Installing jaclang==0.16.7..." -ForegroundColor Yellow
    pip install -r requirements.txt
}

Write-Host "`n[1/3] Running Council of Walkers CLI Test (jac run main.jac)..." -ForegroundColor Green
jac run main.jac

Write-Host "`n[2/3] Opening Interactive Dashboard (index.html)..." -ForegroundColor Green
Start-Process (Join-Path $PSScriptRoot "index.html")

Write-Host "`n[3/3] Starting Jac REST API Server on http://localhost:8000 ..." -ForegroundColor Green
jac start main.jac --port 8000
