<#
.SYNOPSIS
    Linter statique pour fichiers sources LaTeX (.tex) + intégration optionnelle de ChkTeX.
.PARAMETER TargetDir
    Dossier contenant les fichiers .tex à auditer. Défaut : répertoire courant.
.PARAMETER RunChkTeX
    Exécute également chktex (en s'appuyant sur .chktexrc s'il existe dans TargetDir).
#>

[CmdletBinding()]
param (
    [string]$TargetDir = ".",
    [switch]$RunChkTeX
)

if (-not (Test-Path $TargetDir)) {
    Write-Error "Répertoire cible introuvable : $TargetDir"
    exit 1
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Audit LaTeX sur : $TargetDir" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$texFiles = Get-ChildItem -Path $TargetDir -Filter "*.tex" -Recurse | Where-Object {
    $_.FullName -notmatch '[\\/](build|\.venv|\.git)[\\/]'
}

$issueCount = 0

foreach ($file in $texFiles) {
    $lines = Get-Content -Path $file.FullName -Encoding UTF8
    $relPath = Resolve-Path -Path $file.FullName -Relative

    $multilineDepth = 0
    $inVerbatim = $false

    for ($i = 0; $i -lt $lines.Count; $i++) {
        $lineNum = $i + 1
        $line = $lines[$i]

        if ($line -match '\\begin\{(lstlisting|verbatim|Verbatim|minted)\b') { $inVerbatim = $true; continue }
        if ($line -match '\\end\{(lstlisting|verbatim|Verbatim|minted)\b') { $inVerbatim = $false; continue }
        if ($inVerbatim) { continue }

        if ($line -match '\\begin\{(tabular|tabularx|longtable|align|align\*|gather|gather\*|multline|multline\*|split|array|matrix|pmatrix|bmatrix|cases|minipage|flushleft|flushright|center|titlepage)\b') {
            $multilineDepth++
        }
        if ($line -match '\\end\{(tabular|tabularx|longtable|align|align\*|gather|gather\*|multline|multline\*|split|array|matrix|pmatrix|bmatrix|cases|minipage|flushleft|flushright|center|titlepage)\b') {
            if ($multilineDepth -gt 0) { $multilineDepth-- }
        }

        if ($line.Trim().StartsWith("%")) { continue }

        # 1. Commandes de police obsolètes
        if ($line -match '\{\\(bf|it|tt|sc|sl)\b') {
            Write-Host "[POLICE OBSOLÈTE] $relPath : L$lineNum -> $line" -ForegroundColor Red
            $issueCount++
        }

        # 2. Maths display obsolètes $$ ... $$
        if ($line -match '\$\$') {
            Write-Host "[MATH $$ OBSOLÈTE] $relPath : L$lineNum -> Utiliser \[ ... \] ou equation/align" -ForegroundColor Red
            $issueCount++
        }

        # 3. Filets verticaux dans les tableaux
        if ($line -match '\\begin\{tabular[x*]?\}\s*\{[^}]*\|') {
            Write-Host "[FILET VERTICAL |] $relPath : L$lineNum -> Supprimer '|' et utiliser booktabs" -ForegroundColor Yellow
            $issueCount++
        }

        # 4. Citation sans espace insécable ~ (hors \textcite qui agit comme sujet nominal)
        if ($line -match '[a-zA-Z0-9\p{L}\)\]]\s+\\(autocite|cite|parencite|supercite)\{') {
            Write-Host "[~ MANQUANT AVANT CITE] $relPath : L$lineNum -> Ajouter '~' avant la citation" -ForegroundColor Yellow
            $issueCount++
        }

        # 5. Renvoi croisé sans espace insécable ~
        if ($line -match '[a-zA-Z0-9\p{L}\)\]]\s+\\(cref|Cref|cpageref|eqref|ref)\{') {
            Write-Host "[~ MANQUANT AVANT REF] $relPath : L$lineNum -> Ajouter '~' avant le renvoi" -ForegroundColor Yellow
            $issueCount++
        }

        # 6. \hline hérité
        if ($line -match '\\hline') {
            Write-Host "[\hline OBSOLÈTE] $relPath : L$lineNum -> Remplacer par \toprule / \midrule / \bottomrule" -ForegroundColor Yellow
            $issueCount++
        }

        # 7. \\ utilisé comme saut de paragraphe
        if ($multilineDepth -eq 0 -and $line -match '\\\\(\s*$|\s*%)' -and $line -notmatch '\\begin|\\end|\\rule|\\centering') {
            Write-Host "[PARAGRAPHE \\] $relPath : L$lineNum -> Laisser une ligne vide au lieu de \\\\" -ForegroundColor Yellow
            $issueCount++
        }

        # 8. \ref{} manuel au lieu de \cref{} / \Cref{}
        if ($line -match '(?<![a-zA-Z])\\ref\{') {
            Write-Host "[\ref MANUEL] $relPath : L$lineNum -> Préférer \cref{} ou \Cref{}" -ForegroundColor Yellow
            $issueCount++
        }
    }

    # 9. Vérification \caption sans \label (hors \caption*)
    $fullContent = $lines -join "`n"
    $captionMatches = [regex]::Matches($fullContent, '\\caption(?!\*)\{(?:[^{}]|\{(?:[^{}]|\{[^{}]*\})*\})*\}(?!\s*(?:%[^\n]*\n\s*)?\\label)')
    foreach ($cm in $captionMatches) {
        Write-Host "[\label MANQUANT APRÈS \caption] $relPath" -ForegroundColor Yellow
        $issueCount++
    }
}

if ($RunChkTeX) {
    if (Get-Command chktex -ErrorAction SilentlyContinue) {
        Write-Host "`n--- Exécution de ChkTeX ---" -ForegroundColor Cyan
        Push-Location $TargetDir
        try {
            $chkArgs = @("-q", "-v0")
            if (Test-Path ".chktexrc") {
                $chkArgs += @("-l", ".chktexrc")
            }

            if (Test-Path "main.tex") {
                # ChkTeX suit déjà les \input/\include depuis main.tex
                $chkOut = & chktex @chkArgs "main.tex" 2>&1
            } else {
                $relTex = Get-ChildItem -Filter "*.tex" -Recurse | Where-Object {
                    $_.FullName -notmatch '[\\/](build|\.venv|\.git)[\\/]'
                } | ForEach-Object { Resolve-Path -Relative $_.FullName }
                if ($relTex.Count -gt 0) {
                    $chkOut = & chktex @chkArgs "-I0" @relTex 2>&1
                }
            }

            if ($chkOut) {
                $chkOut | ForEach-Object { Write-Host $_ -ForegroundColor Yellow }
                $issueCount += @($chkOut).Count
            } else {
                Write-Host "[OK] ChkTeX : aucun avertissement." -ForegroundColor Green
            }
        } finally {
            Pop-Location
        }
    } else {
        Write-Warning "chktex introuvable dans le PATH."
    }
}

Write-Host "------------------------------------------" -ForegroundColor Cyan
if ($issueCount -eq 0) {
    Write-Host "Succès : aucune anomalie typographique ou syntaxique détectée." -ForegroundColor Green
} else {
    Write-Host "Terminé : $issueCount anomalie(s) détectée(s)." -ForegroundColor Yellow
}
