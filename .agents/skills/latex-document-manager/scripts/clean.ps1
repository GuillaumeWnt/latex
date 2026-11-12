<#
.SYNOPSIS
    Nettoie les fichiers auxiliaires de compilation LaTeX dans build/.
.PARAMETER ProjectDir
    Répertoire racine du projet. Défaut : répertoire courant.
.PARAMETER OutDir
    Répertoire de sortie à nettoyer. Défaut : build.
.PARAMETER All
    Supprime également le PDF final produit.
#>

[CmdletBinding()]
param (
    [string]$ProjectDir = ".",
    [string]$OutDir = "build",
    [switch]$All
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $ProjectDir)) {
    Write-Error "Répertoire introuvable : $ProjectDir"
    exit 1
}

Push-Location $ProjectDir
try {
    if (Get-Command latexmk -ErrorAction SilentlyContinue) {
        if ($All) {
            Write-Host "==> Purge complète (auxiliaires + PDF) dans $OutDir/..." -ForegroundColor Yellow
            latexmk -C "-outdir=$OutDir"
        } else {
            Write-Host "==> Nettoyage des fichiers temporaires dans $OutDir/..." -ForegroundColor Cyan
            latexmk -c "-outdir=$OutDir"
        }
    }

    if (Test-Path $OutDir) {
        $extensions = @("*.aux", "*.bbl", "*.bcf", "*.blg", "*.fdb_latexmk", "*.fls", "*.lof", "*.lot", "*.log", "*.out", "*.run.xml", "*.synctex.gz", "*.toc", "*.tdo", "*.idx", "*.ilg", "*.ind", "*.upa", "*.upb")
        Get-ChildItem -Path $OutDir -Include $extensions -Recurse -ErrorAction SilentlyContinue | Remove-Item -Force
    }

    Write-Host "==> Nettoyage terminé." -ForegroundColor Green
} finally {
    Pop-Location
}
