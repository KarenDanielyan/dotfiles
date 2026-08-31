[CmdletBinding()]
param (
	[ValidateSet('Install', 'Uninstall')]
	[string]$Action = 'Install',
	[string[]]$Packages = @('zed', 'agy', 'agents', 'bash'),
	[string]$Target = $HOME
)

$ErrorActionPreference = 'Stop'
$DotfilesRoot = Split-Path -Parent $PSScriptRoot

# 1. Establish AppData -> .config Junction for Zed
$ZedAppData = "$env:APPDATA\Zed"
$ZedConfig = "$Target\.config\zed"

if ($Action -eq 'Install') {
	if (!(Test-Path $ZedConfig)) {
		New-Item -ItemType Directory -Path $ZedConfig -Force | Out-Null
	}
	if (!(Test-Path $ZedAppData)) {
		New-Item -ItemType Junction -Path $ZedAppData -Target $ZedConfig | Out-Null
		Write-Host "Linked Junction: $ZedAppData -> $ZedConfig" -ForegroundColor Cyan
	}
}

# 2. Replicate Stow symlinks across packages
foreach ($pkg in $Packages) {
	$pkgDir = Join-Path $DotfilesRoot $pkg
	if (!(Test-Path $pkgDir)) { continue }

	Write-Host "==> Processing package: $pkg" -ForegroundColor Magenta

	Get-ChildItem -Path $pkgDir -Recurse -File | ForEach-Object {
		$relativePath = $_.FullName.Substring($pkgDir.Length + 1)
		$destFile = Join-Path $Target $relativePath
		$destDir = Split-Path -Parent $destFile

		if ($Action -eq 'Install') {
			if (!(Test-Path $destDir)) {
				New-Item -ItemType Directory -Path $destDir -Force | Out-Null
			}
			if (Test-Path $destFile) {
				Remove-Item $destFile -Force
			}
			New-Item -ItemType SymbolicLink -Path $destFile -Target $_.FullName -Force | Out-Null
			Write-Host "  Linked: $destFile" -ForegroundColor Green
		}
		elseif ($Action -eq 'Uninstall') {
			if (Test-Path $destFile) {
				Remove-Item $destFile -Force
				Write-Host "  Removed: $destFile" -ForegroundColor Yellow
			}
		}
	}
}
