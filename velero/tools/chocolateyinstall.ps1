# Installs velero from a .tar.gz download link
# see: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64     = 'e1fae1cb5d704ed1e2411f42e1ec60e7cd6bf55b0c2588836b3d29572c9e636d'
  checksumType64 = 'sha256'
  packageName    = $packageName
  unzipLocation  = $toolsDir
  url64bit       = 'https://github.com/vmware-tanzu/velero/releases/download/v1.5.1/velero-v1.5.1-windows-amd64.tar.gz'
}

# Cleanup previous installs
Remove-Item -Path "$toolsDir\*" -Recurse -Force

# Download archived binary
Install-ChocolateyZipPackage @packageArgs

# Untar binary
$file = Get-ChildItem -File -Path $env:ChocolateyInstall\lib\$packageName\tools\ -Filter *.tar
Get-ChocolateyUnzip -fileFullPath $file.FullName -destination $env:ChocolateyInstall\lib\$packageName\tools\
