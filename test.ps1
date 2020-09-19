# Basic chocolatey testing
[CmdletBinding()]
param (
    [String] $ChocoPackageName = $env:CHOCO_PACKAGE_NAME
)

# Vars
$ErrorActionPreference = "Stop"
$nuspecFilename = "$($ChocoPackageName).nuspec"

# Get version from nuspec metadata file
[xml]$spec = Get-Content $nuspecFilename
$version = $spec.package.metadata.version

Write-Output "STARTING tests..."

# Installation test
Write-Output "`nTESTING: Installation of package should work..."
choco install -y --no-progress $ChocoPackageName -source .
if ((-not $?) -and $ErrorActionPreference -eq "Stop") { exit $LastExitCode } # external command error check

# Version test
Write-Output "`nTESTING: Package version output..."
$versionOutput = velero version --client-only | Out-String
if ((-not $?) -and $ErrorActionPreference -eq "Stop") { exit $LastExitCode } # external command error check

if ($versionOutput -match $version) {
    Write-Output "Package version output contained expected version [$version]"
} else {
    throw "ERROR: Package version output doesn't contain expected version [$version]"
}

# Uninstallation test
Write-Output "`nTESTING: Uninstallation of package should work..."
choco uninstall -y $ChocoPackageName -source .
if ((-not $?) -and $ErrorActionPreference -eq "Stop") { exit $LastExitCode } # external command error check

Write-Output "`nFINISHED: tests."
