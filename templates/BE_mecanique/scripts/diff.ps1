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

Push-Location $ProjectDir
try {
    Write-Host "1. Extraction de la version $Revision depuis Git..." -ForegroundColor Cyan
    $oldContent = git show "${Revision}:templates/BE_mecanique/main.tex"
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Erreur : impossible d'extraire la version de référence Git." -ForegroundColor Red
        return
    }
    
    # Écriture en UTF-8 sans BOM
    $utf8NoBom = New-Object System.Text.UTF8Encoding($false)
    [System.IO.File]::WriteAllLines((Join-Path $ProjectDir "main_old.tex"), $oldContent, $utf8NoBom)

    Write-Host "2. Génération des différences avec latexdiff..." -ForegroundColor Cyan
    # Exclusion des tableaux et figures des césures internes pour éviter les erreurs d'alignement TeX
    $diffOutput = latexdiff --config="PICTUREENV=(?:picture|tikzpicture|DIFnomarkup|tabular|tabularx)[*]?" main_old.tex main.tex
    [System.IO.File]::WriteAllLines((Join-Path $ProjectDir "diff.tex"), $diffOutput, $utf8NoBom)

    Write-Host "3. Compilation du PDF différentiel avec LuaLaTeX..." -ForegroundColor Cyan
    latexmk -lualatex -outdir=build -interaction=nonstopmode diff.tex
    if ($LASTEXITCODE -eq 0) {
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

