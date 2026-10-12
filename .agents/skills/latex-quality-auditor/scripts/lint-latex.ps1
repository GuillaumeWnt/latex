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
    
    # Track nesting depth of environments where \\ is legitimate
    $tabularDepth = 0
    
    for ($i = 0; $i -lt $lines.Count; $i++) {
        $lineNum = $i + 1
        $line = $lines[$i]
        
        # Track tabular/align/minipage/flushleft environment depth for \\ check
        if ($line -match '\\begin\{(tabular|tabularx|longtable|align|gather|matrix|pmatrix|bmatrix|cases|minipage|flushleft|flushright|titlepage)\b') { $tabularDepth++ }
        if ($line -match '\\end\{(tabular|tabularx|longtable|align|gather|matrix|pmatrix|bmatrix|cases|minipage|flushleft|flushright|titlepage)\b') { $tabularDepth-- }
        
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

        # 6. Legacy \hline in tables (should use \toprule, \midrule, \bottomrule)
        if ($line -match '\\hline') {
            Write-Host "[LEGACY \hline] $relPath : L$lineNum -> Replace \hline with \toprule / \midrule / \bottomrule (booktabs)" -ForegroundColor Yellow
            $issueCount++
        }

        # 7. \\ used as paragraph break (only flag when NOT inside tabular/align/minipage/etc.)
        if ($tabularDepth -eq 0 -and $line -match '\\\\(\s*$|\s*%)' -and $line -notmatch '\\begin|\\end|\\rule') {
            Write-Host "[PARAGRAPH \\] $relPath : L$lineNum -> Use a blank line for paragraphs, not \\\\" -ForegroundColor Yellow
            $issueCount++
        }

        # 8. Manual \ref{} instead of \cref{}
        if ($line -match '\\ref\{' -and $line -notmatch '\\(cref|Cref|cpageref|pageref|autoref|hyperref|backref)\{') {
            Write-Host "[MANUAL \ref] $relPath : L$lineNum -> Prefer \cref{} or \Cref{} over \ref{}" -ForegroundColor Yellow
            $issueCount++
        }
    }

    # 9. Check for \caption without a following \label in the same float
    $fullContent = $lines -join "`n"
    $captionMatches = [regex]::Matches($fullContent, '\\caption\{[^}]*\}(?!\s*\\label)')
    foreach ($cm in $captionMatches) {
        Write-Host "[MISSING \label AFTER \caption] $relPath -> A \caption{} is not followed by \label{}" -ForegroundColor Yellow
        $issueCount++
    }
}

Write-Host "------------------------------------------" -ForegroundColor Cyan
if ($issueCount -eq 0) {
    Write-Host "Success: Zero typographical or syntax issues detected!" -ForegroundColor Green
} else {
    Write-Host "Completed: $issueCount issue(s) detected across scanned files." -ForegroundColor Yellow
}

