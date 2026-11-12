<#
.SYNOPSIS
    Synchronizes MCP servers from .agents/mcp_config.json to all AI environments.
.DESCRIPTION
    Source of Truth:
      - .agents/mcp_config.json (format: { "mcpServers": { ... } })

    Target Destinations (UTF-8 without BOM):
      - .vscode/mcp.json               (VS Code format: { "servers": { ... }, "inputs": [ ... ] })
      - .mcp.json                      (Claude Code root standard)
      - .claude/mcp.json               (Claude directory standard)
      - .gemini/mcp_config.json        (Gemini workspace config)
      - .gemini/config/mcp_config.json (Antigravity local config format)
#>

[CmdletBinding()]
param (
    [string]$SourceFile = ".agents/mcp_config.json"
)

$ErrorActionPreference = "Stop"

try {
    $RepoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
    $Utf8NoBom = New-Object System.Text.UTF8Encoding($false)

    $ResolvedSource = if ([System.IO.Path]::IsPathRooted($SourceFile)) {
        $SourceFile
    } else {
        Join-Path $RepoRoot $SourceFile
    }

    # 1. Verify and read source file
    if (-not (Test-Path $ResolvedSource)) {
        Write-Warning "Source file $ResolvedSource not found. Creating default empty structure."
        $defaultJson = (@{ mcpServers = @{} } | ConvertTo-Json -Depth 10) + "`n"
        [System.IO.File]::WriteAllText($ResolvedSource, $defaultJson, $Utf8NoBom)
    }

    $rawContent = [System.IO.File]::ReadAllText($ResolvedSource, [System.Text.Encoding]::UTF8)
    $sourceData = $rawContent | ConvertFrom-Json

    if ($null -eq $sourceData.mcpServers) {
        $sourceData | Add-Member -MemberType NoteProperty -Name "mcpServers" -Value ([PSCustomObject]@{})
    }

    # 2. Build VS Code formatted configuration (.vscode/mcp.json)
    $vsCodeServers = [ordered]@{}
    foreach ($property in $sourceData.mcpServers.PSObject.Properties) {
        $name = $property.Name
        $config = $property.Value
        $entry = [ordered]@{}

        if ($config.PSObject.Properties.Match('type').Count -gt 0) {
            $entry['type'] = $config.type
        } elseif ($config.PSObject.Properties.Match('url').Count -gt 0) {
            $entry['type'] = "http"
        } else {
            $entry['type'] = "stdio"
        }

        foreach ($p in $config.PSObject.Properties) {
            if ($p.Name -ne 'type') {
                $entry[$p.Name] = $p.Value
            }
        }
        $vsCodeServers[$name] = [PSCustomObject]$entry
    }

    # Preserve any existing user inputs in .vscode/mcp.json
    $vsCodeTarget = Join-Path $RepoRoot ".vscode\mcp.json"
    $inputs = @()
    if (Test-Path $vsCodeTarget) {
        try {
            $existingVsCode = ([System.IO.File]::ReadAllText($vsCodeTarget, [System.Text.Encoding]::UTF8)) | ConvertFrom-Json
            if ($null -ne $existingVsCode.inputs) {
                $inputs = @($existingVsCode.inputs)
            }
        } catch {}
    }

    $vsCodePayload = [ordered]@{
        servers = [PSCustomObject]$vsCodeServers
        inputs  = $inputs
    }
    $vsCodeJson = ($vsCodePayload | ConvertTo-Json -Depth 10) + "`n"

    $vsCodeDir = Split-Path -Parent $vsCodeTarget
    if (-not (Test-Path $vsCodeDir)) { New-Item -ItemType Directory -Path $vsCodeDir -Force | Out-Null }
    [System.IO.File]::WriteAllText($vsCodeTarget, $vsCodeJson, $Utf8NoBom)

    # 3. Build Standard mcpServers payload (Claude & Gemini)
    $standardPayload = [ordered]@{
        mcpServers = $sourceData.mcpServers
    }
    $standardJson = ($standardPayload | ConvertTo-Json -Depth 10) + "`n"

    $targets = @(
        (Join-Path $RepoRoot ".mcp.json"),
        (Join-Path $RepoRoot ".claude\mcp.json"),
        (Join-Path $RepoRoot ".gemini\mcp_config.json"),
        (Join-Path $RepoRoot ".gemini\config\mcp_config.json")
    )

    foreach ($target in $targets) {
        $dir = Split-Path -Parent $target
        if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
        [System.IO.File]::WriteAllText($target, $standardJson, $Utf8NoBom)
    }

    Write-Host "[OK] MCP servers synchronized across .vscode, .claude, and .gemini from .agents/mcp_config.json (UTF-8 without BOM)." -ForegroundColor Green
} catch {
    Write-Error "Failed to synchronize MCP configurations: $_"
    exit 1
}
