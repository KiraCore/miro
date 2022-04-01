#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x


echo "INFO: Starting build & analyze process..."

rm -rfv ./build

#export PATH="$PATH:$HOME/.pub-cache/bin"
#export PATH="$PATH:./.fvm/flutter_sdk"
#yes | fvm flutter pub upgrade --major-versions

uname -a

FVM_VERSION=$(cat ./.fvm/fvm_config.json | tac | grep -Fn -m 1 '"flutterSdkVersion": ' | rev | cut -d ":" -f1 | rev | xargs | tr -dc '[:alnum:]\-\.')

fvm install $FVM_VERSION

fvm use $FVM_VERSION --force

fvm flutter --version

fvm flutter packages pub get

fvm flutter analyze --no-fatal-infos

# note if the flutter version changes in the .fvm then the "yes pipe" will automatically install necessary dependencies
fvm flutter build web