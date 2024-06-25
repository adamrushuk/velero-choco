![Velero Logo](velero-icon.png "Velero Logo")

<!-- omit from toc -->
# velero-choco

Creates the [Chocolatey package for Velero CLI](https://community.chocolatey.org/packages/velero).

<!-- omit from toc -->
## Content

- [Chocolatey](#chocolatey)
  - [Register](#register)
  - [Api Key](#api-key)
- [Update Velero Package For Chocolatey](#update-velero-package-for-chocolatey)
  - [Check Github Releases For Latest Windows Version / Checksum](#check-github-releases-for-latest-windows-version--checksum)
    - [PowerShell Method](#powershell-method)
    - [Manual Method](#manual-method)
  - [Create New Package Files](#create-new-package-files)
  - [Modify Package Files](#modify-package-files)
  - [Create Nuget Package](#create-nuget-package)
  - [Test Local Install / Uninstall](#test-local-install--uninstall)
  - [Publish Nuget Package To Chocolatey](#publish-nuget-package-to-chocolatey)
  - [Wait For Automated Review Comments](#wait-for-automated-review-comments)

## Chocolatey

### Register

[Register for a Chocolatey account here](https://community.chocolatey.org/account/Register).

### Api Key

Copy your API Key from your [Account > Get API key](https://community.chocolatey.org/account) page.

## Update Velero Package For Chocolatey

### Check Github Releases For Latest Windows Version / Checksum

The Chocolatey installation script requires the correct download URL and checksum for the Windows version of
Velero.

Use either the PowerShell or manual method below:

#### PowerShell Method

```powershell
# Get the latest release of Velero
$veleroReleases = Invoke-RestMethod -Uri 'https://api.github.com/repos/vmware-tanzu/velero/releases'
$latestRelease = $veleroReleases[0]

# Get the CHECKSUM asset content
$checksumAsset = $latestRelease.assets | Where-Object { $_.name -eq 'CHECKSUM' }
$checksumAssetUrl = $checksumAsset.browser_download_url
$checksumAssetContent = Invoke-RestMethod -Uri $checksumAssetUrl

# Get the CHECKSUM value for the Windows Velero release
$match = $checksumAssetContent | Select-String -Pattern '(.*)(?=  .*-windows-amd64.tar.gz)'
if ($match) {
    $windowsAssetChecksum = $match.Matches[0].Value
    Write-Output "The CHECKSUM value for the Windows Velero release is: [$windowsAssetChecksum]"
}
```

#### Manual Method

1. The latest release is listed here: <https://github.com/vmware-tanzu/velero/releases/latest>
1. Search for the `velero-v<VERSION>-windows-amd64.tar.gz` Windows binary asset, and note the download URL.
1. Download the `CHECKSUM` asset and note the checksum value for `velero-v<VERSION>-windows-amd64.tar.gz`.

### Create New Package Files

```bash
# view help
choco new -h

# create new velero package files
choco new --name velero --version=<VERSION> --maintainer="Adam Rush"
```

### Modify Package Files

1. Edit the `velero/velero.nuspec` configuration file, ensuring correct `<version>` and other metadata.
1. Edit the `velero/tools/chocolateyinstall.ps1` install script, ensuring the `$version` and
   `$packageArgs.checksum64` vars are correct for `windows-amd64`.
1. `$packageArgs.url64bit` may need to be updated if the asset name or download URL changes.

### Create Nuget Package

```bash
# view help
choco pack -h

# create velero NuGet package
choco pack
```

### Test Local Install / Uninstall

```bash
# view help
choco install -h

# install from local Nuget package
# eg: velero.<VERSION>.nupkg exists in current folder
choco install velero --source .

# [OPTIONAL] test upgrade if previous version is already installed
choco upgrade velero --source .

# check version
velero version --client-only

# uninstall
choco uninstall velero
```

### Publish Nuget Package To Chocolatey

```bash
# copy your API Key from the My Account page: https://chocolatey.org/account/
choco apikey --key <YOUR_API_KEY> --source https://push.chocolatey.org/

# view help
choco push -h

# publish Nuget package
# eg: velero.<VERSION>.nupkg exists in current folder
choco push velero.<VERSION>.nupkg --source https://push.chocolatey.org/

# [OPTIONAL]
# once a package is approved, it's immutable, therefore you cannot push this same version.
# push a fixed version by appending the date (velero.<VERSION>.<DATE>.nupkg), eg:
choco push velero.1.5.1.20200919.nupkg --source https://push.chocolatey.org/
```

### Wait For Automated Review Comments

Once you submit the package, Chocolatey will run automated Validation and Verification tests.

You may receive comments like the following:

- The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.
- The licenseUrl should be added if there is one. Please correct this in the nuspec, if applicable.

Make the suggested changes, then create a new NuGet package and publish as before, ensuring you use the same
version.
