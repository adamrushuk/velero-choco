# Installs velero from a .tar.gz download link
# see: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64     = 'b18c1a5156b2cd45fe87082ee9b5a83546b2a68c41198f709b4207a28135b45c'
  checksumType64 = 'sha256'
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/vmware-tanzu/velero/releases/download/v1.5.3/velero-v1.5.3-windows-amd64.tar.gz'
}

# Cleanup previous installs
Remove-Item -Path "$toolsDir\*" -Recurse -Force

# Download archived binary
Install-ChocolateyZipPackage @packageArgs

# Untar binary
$file = Get-ChildItem -File -Path $env:ChocolateyInstall\lib\$packageName\tools\ -Filter *.tar
Get-ChocolateyUnzip -fileFullPath $file.FullName -destination $env:ChocolateyInstall\lib\$packageName\tools\
