#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

BASE_IMAGE_VERSION="v0.8.0.0"

echo "INFO: Starting cleanup process..."
uname -a

yes | fvm flutter clean || echo "WARNING: Failed fvm clean" && sleep 3

./scripts/kira-stop.sh || echo "WARNING: Failed to stop local KIRA Network" && sleep 3

./scripts/docker-stop.sh || echo "WARNING: Failed to stop docker" && sleep 3

rm -rfv ./build ./bin ./.dart_tool ./.packages ./.flutter-*

