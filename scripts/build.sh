#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x


echo "INFO: Starting build & analyze process..."
uname -a

rm -rfv ./build

FVM_VERSION=$(cat ./.fvm/fvm_config.json | tac | grep -Fn -m 1 '"flutterSdkVersion": ' | rev | cut -d ":" -f1 | rev | xargs | tr -dc '[:alnum:]\-\.')

fvm install $FVM_VERSION

fvm use $FVM_VERSION --force

fvm flutter --version

fvm flutter packages pub get

fvm flutter analyze --no-fatal-infos

fvm flutter build web