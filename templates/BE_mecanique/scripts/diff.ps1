<#
.SYNOPSIS
  Script de génération automatique du PDF comparatif (git diff visuel) avec latexdiff.
.DESCRIPTION
  Compare la version committée dans Git (HEAD ou révision au choix) avec la version actuelle,
  génère le diff.tex en encodage UTF-8 propre, puis compile build/diff.pdf avec LuaLaTeX.
.PARAMETER Revision
  La révision Git à comparer (défaut : HEAD).
#>
[CmdletBinding()]
param (
    [string]$Revision = "HEAD"
)

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Definition
$ProjectDir = Split-Path -Parent $ScriptDir

# Forcer l'encodage console en UTF-8 pour git et les outils externes
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Push-Location $ProjectDir
try {
    Write-Host "1. Extraction de la version $Revision depuis Git en UTF-8..." -ForegroundColor Cyan
    $oldContent = git show "${Revision}:templates/BE_mecanique/main.tex"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Erreur : impossible d'extraire la version de référence Git." -ForegroundColor Red
        return
    }
    
    # Écriture en UTF-8 sans BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllLines((Join-Path $ProjectDir "main_old.tex"), $oldContent, $utf8NoBom)

    Write-Host "2. Génération des différences avec latexdiff (UTF-8 & protection tableaux)..." -ForegroundColor Cyan
    # Options latexdiff : encodage UTF-8 et exclusion des tableaux/figures des césures fragiles
    cmd /c "latexdiff --encoding=utf8 --config=""PICTUREENV=(?:picture|tikzpicture|DIFnomarkup|tabular|tabularx)[*]?"" main_old.tex main.tex > diff.tex"

    Write-Host "3. Compilation du PDF différentiel avec LuaLaTeX..." -ForegroundColor Cyan
    latexmk -f -lualatex -outdir=build -interaction=nonstopmode diff.tex
    if (Test-Path "build/diff.pdf") {
        Write-Host "Succès ! Le PDF comparatif est disponible dans build/diff.pdf" -ForegroundColor Green
    } else {
        Write-Host "Erreur lors de la compilation de diff.tex. Vérifiez build/diff.log" -ForegroundColor Red
    }
} finally {
    # Nettoyage du fichier intermédiaire main_old.tex
    if (Test-Path "main_old.tex") {
        Remove-Item -Force "main_old.tex" -ErrorAction SilentlyContinue
    }
    Pop-Location
}
