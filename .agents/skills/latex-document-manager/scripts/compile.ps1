<#
.SYNOPSIS
    Compile un projet LaTeX avec LuaLaTeX via latexmk et analyse les erreurs/avertissements du log.
.PARAMETER ProjectDir
    Répertoire racine du projet contenant main.tex. Défaut : répertoire courant.
.PARAMETER Target
    Fichier maître .tex à compiler. Défaut : main.tex.
.PARAMETER OutDir
    Répertoire de sortie des fichiers de compilation. Défaut : build.
#>

[CmdletBinding()]
param (
    [string]$ProjectDir = ".",
    [string]$Target = "main.tex",
    [string]$OutDir = "build"
)

$ErrorActionPreference = "Stop"

if (-not (Test-Path $ProjectDir)) {
    Write-Error "Répertoire introuvable : $ProjectDir"
    exit 1
}

if (-not (Get-Command latexmk -ErrorAction SilentlyContinue)) {
    Write-Error "latexmk est introuvable dans le PATH."
    exit 1
}

$resolvedDir = (Resolve-Path $ProjectDir).Path
$baseName = [System.IO.Path]::GetFileNameWithoutExtension($Target)
$logFile = Join-Path $resolvedDir "$OutDir\$baseName.log"

Push-Location $resolvedDir
try {
    if (-not (Test-Path $Target)) {
        Write-Error "Fichier cible introuvable : $Target dans $resolvedDir"
        exit 1
    }

    Write-Host "==> Compilation LuaLaTeX : $resolvedDir\$Target" -ForegroundColor Cyan

    latexmk -lualatex "-outdir=$OutDir" -interaction=nonstopmode -synctex=1 $Target
    $exitCode = $LASTEXITCODE

    if (Test-Path $logFile) {
        $logLines = Get-Content $logFile -Encoding UTF8 -ErrorAction SilentlyContinue
        $fatalErrors = @($logLines | Where-Object { $_ -match '^!' })
        $warnings = @($logLines | Where-Object { $_ -match 'LaTeX Warning:|Package .* Warning:|Class .* Warning:|Missing character:' })
        $overfull = @($logLines | Where-Object { $_ -match 'Overfull \\hbox|Overfull \\vbox' })

        Write-Host "`n--- Bilan du log ($OutDir/$baseName.log) ---" -ForegroundColor Cyan
        Write-Host "  Erreurs fatales (!) : $($fatalErrors.Count)" -ForegroundColor $(if ($fatalErrors.Count -eq 0) { "Green" } else { "Red" })
        Write-Host "  Avertissements      : $($warnings.Count)" -ForegroundColor $(if ($warnings.Count -eq 0) { "Green" } else { "Yellow" })
        Write-Host "  Overfull boxes      : $($overfull.Count)" -ForegroundColor $(if ($overfull.Count -eq 0) { "Green" } else { "Yellow" })

        if ($fatalErrors.Count -gt 0) {
            Write-Host "`n[ERREURS FATALES]" -ForegroundColor Red
            $fatalErrors | Select-Object -First 10 | ForEach-Object { Write-Host "  $_" -ForegroundColor Red }
        }
        if ($warnings.Count -gt 0) {
            Write-Host "`n[AVERTISSEMENTS]" -ForegroundColor Yellow
            $warnings | Select-Object -First 15 | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
        }
        if ($overfull.Count -gt 0) {
            Write-Host "`n[OVERFULL BOXES (aperçu)]" -ForegroundColor Yellow
            $overfull | Select-Object -First 10 | ForEach-Object { Write-Host "  $_" -ForegroundColor Yellow }
        }
    }

    if ($exitCode -ne 0) {
        Write-Host "`n==> Échec de compilation (code $exitCode)." -ForegroundColor Red
        exit $exitCode
    }

    Write-Host "`n==> Compilation réussie : $OutDir/$baseName.pdf" -ForegroundColor Green
} finally {
    Pop-Location
}
