# Installs velero from a .tar.gz download link
# see CHECKSUM and assets: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$version = '1.8.1'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64     = '1643d917325ae022c9f1cc8021212826116302a7056a32d55f400380baa3716a'
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
