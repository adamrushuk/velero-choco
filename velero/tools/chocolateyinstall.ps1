# Installs velero from a .tar.gz download link
# see: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$version = '1.5.4'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64     = '86be440bf597178a16ff202ff113ecc716fc300cf7a821ec12f1e82f255a7ea0'
  checksumType64 = 'sha256'
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = "https://github.com/vmware-tanzu/velero/releases/download/v$version/velero-v$version-windows-amd64.tar.gz"
}

# Cleanup previous installs
Remove-Item -Path "$toolsDir\*" -Recurse -Force

# Download archived binary
Install-ChocolateyZipPackage @packageArgs

# Untar binary
$file = Get-ChildItem -File -Path $env:ChocolateyInstall\lib\$packageName\tools\ -Filter *.tar
Get-ChocolateyUnzip -fileFullPath $file.FullName -destination $env:ChocolateyInstall\lib\$packageName\tools\
