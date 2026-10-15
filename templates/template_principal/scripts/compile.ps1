<#
.SYNOPSIS
  Script de compilation automatique pour le template avec LuaLaTeX et Biber.
.DESCRIPTION
  Exécute latexmk avec le moteur LuaLaTeX et génère la sortie dans le dossier build/.
#>

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectDir = Split-Path -Parent $ScriptDir

Push-Location $ProjectDir
try {
    Write-Host "Compilation en cours avec LuaLaTeX..." -ForegroundColor Cyan
    latexmk -lualatex -outdir=build -interaction=nonstopmode -synctex=1 main.tex
    if ($LASTEXITCODE -eq 0) {
        Write-Host "Compilation réussie ! Le PDF est disponible dans build/main.pdf" -ForegroundColor Green
    } else {
        Write-Host "Erreur lors de la compilation. Vérifiez build/main.log" -ForegroundColor Red
    }
} finally {
    Pop-Location
}

