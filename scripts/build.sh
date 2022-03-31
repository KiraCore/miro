#!/usr/bin/env bash
set -e
set -x

echo "INFO: Starting build & analyze process..."

rm -rfv ./build

yes | fvm flutter packages pub get

yes | fvm flutter analyze --no-fatal-infos

# note if the flutter version changes in the .fvm then the "yes pipe" will automatically install necessary dependencies
yes | fvm flutter build web