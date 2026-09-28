# Installs velero from a .tar.gz download link
# download CHECKSUM (search for "windows") and assets: https://github.com/vmware-tanzu/velero/releases

$ErrorActionPreference = 'Stop'

# vars
$packageName = 'velero'
$version = '1.18.4'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$packageArgs = @{
  checksum64     = '13a06e9b4772e2a3d7ba75df5f7190a9021c46d48d7ba057cf8df9db3bfad73f'
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









