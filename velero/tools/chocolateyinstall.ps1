# Installs velero from a .tar.gz download link
# download CHECKSUM (search for "windows-amd64") and assets: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$version = '1.9.3'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64     = '0f3fb0ecc0b99aba2e8a6e4f1a46cb591cf5bf00536180b46aac7e584b2bffcf'
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
