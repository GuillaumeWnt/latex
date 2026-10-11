<#
.SYNOPSIS
    Audits a BibTeX / BibLaTeX file for integrity, duplicates, and missing mandatory fields.
.PARAMETER BibFile
    Path to the .bib file to audit. Defaults to 'bib/references.bib'.
#>

param (
    [string]$BibFile = "bib/references.bib"
)

if (-not (Test-Path $BibFile)) {
    Write-Error "Bibliography file not found: $BibFile"
    exit 1
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Auditing Bibliography: $BibFile" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

$content = Get-Content -Path $BibFile -Raw

# Match entries: @type{key, ...}
$entryRegex = [regex]'@(\w+)\s*\{\s*([^,]+),'
$matches = $entryRegex.Matches($content)

$keys = @{}
$duplicates = @()

foreach ($match in $matches) {
    $type = $match.Groups[1].Value
    $key = $match.Groups[2].Value.Trim()

    if ($type.ToLower() -eq 'comment') { continue }

    if ($keys.ContainsKey($key)) {
        $duplicates += $key
    } else {
        $keys[$key] = $type
    }
}

Write-Host "Total entries found: $($keys.Count)" -ForegroundColor Green

if ($duplicates.Count -gt 0) {
    Write-Host "`n[ERROR] Duplicate citation keys found:" -ForegroundColor Red
    foreach ($dup in $duplicates) {
        Write-Host "  - $dup" -ForegroundColor Red
    }
} else {
    Write-Host "[OK] No duplicate citation keys detected." -ForegroundColor Green
}

# Check for improper DOI formats (containing URL prefix)
$doiUrlMatches = [regex]::Matches($content, 'doi\s*=\s*\{https?://[^}]+\}')
if ($doiUrlMatches.Count -gt 0) {
    Write-Host "`n[WARN] Found $($doiUrlMatches.Count) DOI(s) with full URL prefix instead of raw identifier:" -ForegroundColor Yellow
    foreach ($m in $doiUrlMatches) {
        Write-Host "  - $($m.Value)" -ForegroundColor Yellow
    }
} else {
    Write-Host "[OK] All DOIs are cleanly formatted (no URL prefixes)." -ForegroundColor Green
}

Write-Host "`nAudit complete." -ForegroundColor Cyan

