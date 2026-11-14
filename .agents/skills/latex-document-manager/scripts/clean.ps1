<#
.SYNOPSIS
    Nettoie les fichiers intermédiaires de compilation LaTeX dans build/ en préservant le PDF et les fichiers utiles au débogage/reprise.
.PARAMETER ProjectDir
    Répertoire racine du projet. Défaut : répertoire courant.
.PARAMETER OutDir
    Répertoire de sortie à nettoyer. Défaut : build.
.PARAMETER All
    Purge complète : supprime également le PDF final et les fichiers de suivi/débogage (.log, .synctex.gz, .blg, .fdb_latexmk, .fls).
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
    $disposableExtensions = @(
        "*.aux", "*.bbl", "*.bcf", "*.lof", "*.lot", "*.out",
        "*.run.xml", "*.toc", "*.tdo", "*.idx", "*.ilg", "*.ind", "*.upa", "*.upb"
    )
    $debugAndTrackingExtensions = @("*.synctex.gz", "*.log", "*.blg", "*.fdb_latexmk", "*.fls")

    if ($All) {
        Write-Host "==> Purge complète (auxiliaires + débogage + PDF) dans $OutDir/..." -ForegroundColor Yellow
        if (Get-Command latexmk -ErrorAction SilentlyContinue) {
            latexmk -C "-outdir=$OutDir"
        }
        if (Test-Path $OutDir) {
            $allExtensions = $disposableExtensions + $debugAndTrackingExtensions + @("*.pdf")
            Get-ChildItem -Path $OutDir -Include $allExtensions -Recurse -File -ErrorAction SilentlyContinue | Remove-Item -Force
        }
    } else {
        Write-Host "==> Nettoyage ciblé dans $OutDir/ (préservation des .pdf, .synctex.gz, .log, .blg, .fdb_latexmk, .fls)..." -ForegroundColor Cyan
        if (Test-Path $OutDir) {
            Get-ChildItem -Path $OutDir -Include $disposableExtensions -Recurse -File -ErrorAction SilentlyContinue | Remove-Item -Force
        }
    }

    Write-Host "==> Nettoyage terminé." -ForegroundColor Green
} finally {
    Pop-Location
}
