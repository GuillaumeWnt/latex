<#
.SYNOPSIS
    Cleans auxiliary LaTeX compilation files.
#>

param (
    [string]$OutDir = "build"
)

Write-Host "==> Purging auxiliary build artifacts in $OutDir/..." -ForegroundColor Cyan

if (Get-Command latexmk -ErrorAction SilentlyContinue) {
    latexmk -c -outdir=$OutDir
}

$extensions = @("*.aux", "*.bbl", "*.blg", "*.log", "*.out", "*.toc", "*.fls", "*.fdb_latexmk", "*.synctex.gz")
foreach ($ext in $extensions) {
    Get-ChildItem -Path $OutDir -Filter $ext -ErrorAction SilentlyContinue | Remove-Item -Force
}

Write-Host "==> Clean complete." -ForegroundColor Green

