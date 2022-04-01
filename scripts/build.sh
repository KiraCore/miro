#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x


echo "INFO: Starting build & analyze process..."

rm -rfv ./build

#export PATH="$PATH:$HOME/.pub-cache/bin"
#export PATH="$PATH:./.fvm/flutter_sdk"
#yes | fvm flutter pub upgrade --major-versions

yes | fvm flutter --version

yes | fvm flutter packages pub get

yes | fvm flutter analyze --no-fatal-infos

# note if the flutter version changes in the .fvm then the "yes pipe" will automatically install necessary dependencies
yes | fvm flutter build web