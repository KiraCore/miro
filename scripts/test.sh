#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting unit tests..."

uname -a
CHROME_EXECUTABLE=$(which google-chrome || which chrome || which chromium-browser || which chromium)
CHROMIUM_VERSION=$($CHROME_EXECUTABLE --version || echo "")

fvm flutter doctor -v

if [ ! -z "$CHROMIUM_VERSION" ] ; then
    export CHROME_EXECUTABLE="$CHROME_EXECUTABLE"
    fvm flutter test test/unit --platform chrome
else
    echo "ERROR: chrome or chromium must be installed and added to your PATH!"
    echo "INFO: Reccomended solution: 'add-apt-repository -y ppa:system76/pop && apt install -y chromium-browser'"
    exit 1
fi
