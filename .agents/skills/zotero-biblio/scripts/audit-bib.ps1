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

# Check for missing mandatory fields (author, title)
$entryBlocks = [regex]::Matches($content, '(?s)@(\w+)\s*\{\s*([^,]+),([^@]*)')
$missingFields = @()
foreach ($block in $entryBlocks) {
    $entryType = $block.Groups[1].Value.ToLower()
    $entryKey = $block.Groups[2].Value.Trim()
    $body = $block.Groups[3].Value

    if ($entryType -eq 'comment' -or $entryType -eq 'preamble' -or $entryType -eq 'string') { continue }

    if ($body -notmatch 'author\s*=') {
        $missingFields += "[MISSING author] in entry '$entryKey'"
    }
    if ($body -notmatch 'title\s*=') {
        $missingFields += "[MISSING title] in entry '$entryKey'"
    }
    if ($entryType -eq 'article' -and $body -notmatch '(journal|journaltitle)\s*=') {
        $missingFields += "[MISSING journal] in @article entry '$entryKey'"
    }
}

if ($missingFields.Count -gt 0) {
    Write-Host "`n[WARN] Missing mandatory fields:" -ForegroundColor Yellow
    foreach ($mf in $missingFields) {
        Write-Host "  - $mf" -ForegroundColor Yellow
    }
} else {
    Write-Host "[OK] All entries have required fields (author, title)." -ForegroundColor Green
}

# Check citation key naming convention: [author][year] pattern
$badKeys = @()
foreach ($key in $keys.Keys) {
    if ($key -notmatch '^[a-z]+\d{4}') {
        $badKeys += $key
    }
}

if ($badKeys.Count -gt 0) {
    Write-Host "`n[INFO] Keys not matching [author][year] convention:" -ForegroundColor Cyan
    foreach ($bk in $badKeys) {
        Write-Host "  - $bk ($($keys[$bk]))" -ForegroundColor Cyan
    }
}

Write-Host "`nAudit complete." -ForegroundColor Cyan

