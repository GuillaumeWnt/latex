<#
.SYNOPSIS
  Script de nettoyage des fichiers auxiliaires de compilation.
.DESCRIPTION
  Supprime les fichiers temporaires du dossier build/ tout en conservant le PDF généré.
  Ajouter le paramètre -All pour purger également le PDF.
#>

param (
    [switch]$All
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectDir = Split-Path -Parent $ScriptDir

Push-Location $ProjectDir
try {
    if ($All) {
        Write-Host "Purge complète (fichiers temporaires et PDF)..." -ForegroundColor Yellow
        latexmk -C -outdir=build
    } else {
        Write-Host "Nettoyage des fichiers temporaires..." -ForegroundColor Yellow
        latexmk -c -outdir=build
    }
} finally {
    Pop-Location
}

