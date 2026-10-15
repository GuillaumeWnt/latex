<#
.SYNOPSIS
  Script de nettoyage des fichiers auxiliaires de compilation pour labo_PID.
.PARAMETER All
  Supprime également le fichier PDF généré si spécifié.
#>
[CmdletBinding()]
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
        if (Test-Path "build") {
            Remove-Item -Recurse -Force "build" -ErrorAction SilentlyContinue
        }
    } else {
        Write-Host "Nettoyage des fichiers temporaires auxiliaires..." -ForegroundColor Yellow
        latexmk -c -outdir=build
    }
    Write-Host "Nettoyage terminé." -ForegroundColor Green
} finally {
    Pop-Location
}

