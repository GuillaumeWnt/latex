<#
.SYNOPSIS
    Static analysis linter for LaTeX source files.
.DESCRIPTION
    Scans .tex files for obsolete font commands, obsolete display math ($$),
    vertical lines in tables, and missing non-breaking spaces before citations/cross-references.
.PARAMETER TargetDir
    The directory containing .tex files to audit. Defaults to current directory.
#>

param (
    [string]$TargetDir = "."
)

if (-not (Test-Path $TargetDir)) {
    Write-Error "Target directory not found: $TargetDir"
    exit 1
}

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host " Running LaTeX Linter on: $TargetDir" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

$texFiles = Get-ChildItem -Path $TargetDir -Filter "*.tex" -Recurse | Where-Object { $_.FullName -notmatch "build" }

$issueCount = 0

foreach ($file in $texFiles) {
    $lines = Get-Content -Path $file.FullName
    $relPath = Resolve-Path -Path $file.FullName -Relative
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $lineNum = $i + 1
        $line = $lines[$i]
        
        # Skip commented lines
        if ($line.Trim().StartsWith("%")) { continue }
        
        # 1. Obsolete font commands: {\bf, {\it, {\tt, etc.
        if ($line -match '\{\\(bf|it|tt|sc|sl)\b') {
            Write-Host "[OBSOLETE FONT] $relPath : L$lineNum -> $line" -ForegroundColor Red
            $issueCount++
        }
        
        # 2. Obsolete display math: $$ ... $$
        if ($line -match '\$\$') {
            Write-Host "[OBSOLETE MATH] $relPath : L$lineNum -> Use \[ ... \] instead of $$" -ForegroundColor Red
            $issueCount++
        }
        
        # 3. Vertical lines in tables: \begin{tabular}{| or {|c|
        if ($line -match '\\begin\{tabular[x*]?\}\s*\{[^}]*\|') {
            Write-Host "[VERTICAL LINE IN TABLE] $relPath : L$lineNum -> Remove vertical bars '|' and use booktabs" -ForegroundColor Yellow
            $issueCount++
        }
        
        # 4. Citation without non-breaking space (e.g. "word \cite{" instead of "word~\cite{")
        if ($line -match '[a-zA-Z0-9]\s+\\(autocite|cite|parencite)\{') {
            Write-Host "[MISSING ~ BEFORE CITE] $relPath : L$lineNum -> Add non-breaking space '~' before citation" -ForegroundColor Yellow
            $issueCount++
        }
        
        # 5. Cross-reference without non-breaking space
        if ($line -match '[a-zA-Z0-9]\s+\\(cref|Cref|ref)\{') {
            Write-Host "[MISSING ~ BEFORE CREF] $relPath : L$lineNum -> Add non-breaking space '~' before reference" -ForegroundColor Yellow
            $issueCount++
        }
    }
}

Write-Host "------------------------------------------" -ForegroundColor Cyan
if ($issueCount -eq 0) {
    Write-Host "Success: Zero typographical or syntax issues detected!" -ForegroundColor Green
} else {
    Write-Host "Completed: $issueCount issue(s) detected across scanned files." -ForegroundColor Yellow
}

