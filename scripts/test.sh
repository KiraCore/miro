#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting unit tests..."

CHROMIUM_VERSION=$(/usr/bin/chromium --version || echo "")
if [ ! -z "$CHROMIUM_VERSION" ] ; then
    export CHROME_EXECUTABLE="/usr/bin/chromium"

    #fvm flutter test test/unit --platform chrome
    fvm flutter test test/unit/providers --platform chrome
    fvm flutter test test/unit/shared --platform chrome
else
    echo "ERROR: chromium must be installed in '/usr/bin/chromium' to run tests"
    exit 1
fi
