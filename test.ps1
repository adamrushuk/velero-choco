# original source: https://github.com/virtualex-itv/choco-lens/blob/master/test.ps1
$ErrorActionPreference = "Stop"

# vars
$chocoPackageName = "velero"
$nuspecFilename = "$($chocoPackageName).nuspec"
$expectedZipEntries = 5

# get version
[xml]$spec = Get-Content $nuspecFilename
$version = $spec.package.metadata.version

Write-Output "Running tests..."

Write-Output "TEST: NuGet Package should contain [$expectedZipEntries] entries..."
Add-Type -assembly "system.io.compression.filesystem"
$zip = [IO.Compression.ZipFile]::OpenRead("$pwd\$($chocoPackageName).$version.nupkg")

Write-Output "[$zip.Entries.Count] zip entries found."
if ($zip.Entries.Count -ne $expectedZipEntries) {
    Write-Error "FAIL: Wrong count in nupkg!"
}
$zip.Dispose()

Write-Output "TEST: Installation of package should work..."
choco install -y $chocoPackageName -source . -version $version

Write-Output "TEST: Package version output..."
velero version --client-only

Write-Output "TEST: Uninstallation of package should work..."
choco uninstall -y $chocoPackageName -source .

Write-Output "TEST: Finished"
