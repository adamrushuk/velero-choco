# create new package for velero
#
# source: https://chocolatey.org/docs/create-packages-quick-start

# create new package files
choco new -h
choco new --name velero --version=1.4.0 --maintainer="Adam Rush"

# move into package folder
cd velero

# Edit the velero.nuspec configuration file.
# Edit the ./tools/chocolateyInstall.ps1 install script.

# create nuget package
choco pack

# test local install
choco install -h
choco install velero -s .

# Configure your local environment to use your API key
# View your API Key on the My Account page: https://chocolatey.org/account/
choco apikey --key <YOUR_API_KEY> --source https://push.chocolatey.org/

# Publish package to community feed
choco push velero.1.4.0.nupkg --source https://push.chocolatey.org/
