# Basic chocolatey testing
[CmdletBinding()]
param (
    [String] $ChocoPackageName = $env:CHOCO_PACKAGE_NAME
)

# vars
$ErrorActionPreference = "Stop"
$nuspecFilename = "$($ChocoPackageName).nuspec"

# get version
[xml]$spec = Get-Content $nuspecFilename
$version = $spec.package.metadata.version

Write-Output "STARTING tests..."

Write-Output "`nTESTING: Installation of package should work..."
choco install -y $ChocoPackageName -source .
if ((-not $?) -and $ErrorActionPreference -eq "Stop") { exit $LastExitCode } # external command error check

Write-Output "`nTESTING: Package version output..."
velero version --client-only
if ((-not $?) -and $ErrorActionPreference -eq "Stop") { exit $LastExitCode } # external command error check

Write-Output "`nTESTING: Uninstallation of package should work..."
choco uninstall -y $ChocoPackageName -source .
if ((-not $?) -and $ErrorActionPreference -eq "Stop") { exit $LastExitCode } # external command error check

Write-Output "`nFINISHED: tests."
