<#
.SYNOPSIS
    Compiles the main LaTeX document into build/ using latexmk.
.DESCRIPTION
    Checks if latexmk is installed, runs it with PDF engine and SyncTeX, and validates output.
#>

param (
    [string]$Target = "main.tex",
    [string]$OutDir = "build"
)

Write-Host "==> Compiling LaTeX document: $Target" -ForegroundColor Cyan

if (Get-Command latexmk -ErrorAction SilentlyContinue) {
    latexmk -pdf -outdir=$OutDir -interaction=nonstopmode -synctex=1 $Target
    if ($LASTEXITCODE -eq 0) {
        Write-Host "==> Compilation succeeded! PDF output in $OutDir/" -ForegroundColor Green
    } else {
        Write-Host "==> Compilation failed. Check $OutDir/main.log for details." -ForegroundColor Red
    }
} elseif (Get-Command pdflatex -ErrorAction SilentlyContinue) {
    Write-Host "latexmk not found, falling back to pdflatex..." -ForegroundColor Yellow
    if (-not (Test-Path $OutDir)) { New-Item -ItemType Directory -Path $OutDir | Out-Null }
    pdflatex -output-directory=$OutDir -interaction=nonstopmode $Target
} else {
    Write-Host "Error: No TeX distribution (latexmk / pdflatex) detected in PATH." -ForegroundColor Red
    exit 1
}

