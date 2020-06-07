![Velero Logo](velero-icon.png "Velero Logo")

# velero-choco

Creates a Chocolatey package for Velero CLI.

## Register

Register for an account here: https://chocolatey.org/account/Register

## API Key

Copy your API Key on the My Account page: https://chocolatey.org/account/

## Check GitHub releases for latest version

The latest release is listed here: https://github.com/vmware-tanzu/velero/releases

Search for the Windows binary, named `velero-v<VERSION>-windows-amd64.tar.gz`

## Create new package files

```powershell
# view help
choco new -h

# create new velero package files
choco new --name velero --version=1.4.0 --maintainer="Adam Rush"
```

## Modify package files

1. Move into package folder: `cd velero`
1. Edit the `velero.nuspec` configuration file.
1. Edit the `./tools/chocolateyInstall.ps1` install script.

## Create NuGet package

```powershell
# view help
choco pack -h

# create velero NuGet package
choco pack
```

## Test local install

```powershell
# view help
choco install -h

# install from local Nuget package
# eg: velero.1.4.0.nupkg exists in current folder
choco install velero --source .
```

## Publish NuGet package to Chocolatey

```powershell
# Copy your API Key from the My Account page: https://chocolatey.org/account/
choco apikey --key <YOUR_API_KEY> --source https://push.chocolatey.org/

# view help
choco push -h

# publish Nuget package
# eg: velero.1.4.0.nupkg exists in current folder
choco push velero.1.4.0.nupkg --source https://push.chocolatey.org/
```

## Wait for automated review comments

Once you submit the package, Chocolatey will run automated Validation and Verification tests.

You may receive comments like the following:

- The iconUrl should be added if there is one. Please correct this in the nuspec, if applicable.
- The licenseUrl should be added if there is one. Please correct this in the nuspec, if applicable.

Make the suggested changes, then create a new NuGet package and publish as before, ensuring you use the same version.
