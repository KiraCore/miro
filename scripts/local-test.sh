#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting local integration tests..."

CHROMIUM_VERSION=$(/usr/bin/chromium --version || echo "")
if [ ! -z "$CHROMIUM_VERSION" ] ; then
    export CHROME_EXECUTABLE="/usr/bin/chromium"
    ./scripts/kira-start.sh
    # TODO: Run tests
    #fvm flutter test test/integration/infra/deposit_service_test.dart --platform chrome
    ./scripts/kira-stop.sh
else
    echo "ERROR: chromium must be installed in '/usr/bin/chromium' to run tests"
    echo "INFO: Reccomended solution: 'add-apt-repository -y ppa:system76/pop && apt install -y chromium'"
    exit 1
fi
