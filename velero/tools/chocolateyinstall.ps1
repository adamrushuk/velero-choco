# Installs velero from a .tar.gz download link
# see: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64    = 'bc4e9d59929156af599e6899494f414a38233b146003083143d8422602340c6b'
  checksumType64= 'sha256'
  packageName   = $packageName
  unzipLocation = $toolsDir
  url64bit      = 'https://github.com/vmware-tanzu/velero/releases/download/v1.4.0/velero-v1.4.0-windows-amd64.tar.gz'
}

# Download archived binary
Install-ChocolateyZipPackage @packageArgs

# Untar binary
$file = Get-ChildItem -File -Path $env:ChocolateyInstall\lib\$packageName\tools\ -Filter *.tar
Get-ChocolateyUnzip -fileFullPath $file.FullName -destination $env:ChocolateyInstall\lib\$packageName\tools\
