#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting unit tests..."

uname -a
CHROME_EXECUTABLE=$(which google-chrome-unstable || which chrome || which google-chrome || which chromium-browser || which chromium)
CHROMEDRIVER_EXECUTABLE=$(which chromedriver || echo "")
CHROMIUM_VERSION=$($CHROME_EXECUTABLE --version || echo "")
CHROMEDRIVER_VERSION=$($CHROMEDRIVER_EXECUTABLE --version || echo "")

fvm flutter doctor -v

# This command is essential for all VM environments due to git security policies
git config --global --add safe.directory /usr/lib/flutter

echoInfo "INFO: Starting browser NOT dependent unit tests..."
fvm flutter test test/unit/shared
fvm flutter test test/unit/providers/menu_provider_test.dart

echoInfo "INFO: Starting browser dependent unit tests..."
if [ ! -z "$CHROMEDRIVER_VERSION" ] ; then
    service dbus start || echoWarn "WARNINIG: Failed to start dbus"
    systemctl restart chromedriver || echoWarn "WARNINIG: Failed to restart chromedriver service"
    
    # The --release flag is essential for running browser dependent tests in UI, see https://github.com/jonsamwell/flutter_gherkin/issues/66
    fvm flutter drive --driver=test_driver/integration_test.dart --target=test/unit/blocs/lists/balance_list_bloc_test.dart -d web-server --release
    fvm flutter drive --driver=test_driver/integration_test.dart --target=test/unit/blocs/network_connector_cubit_test.dart -d web-server --release
    fvm flutter drive --driver=test_driver/integration_test.dart --target=test/unit/blocs/drawer_cubit_test.dart -d web-server --release 
    fvm flutter drive --driver=test_driver/integration_test.dart --target=test/unit/providers/network_provider_test.dart -d web-server --release
elif [ ! -z "$CHROMIUM_VERSION" ] ; then
    export CHROME_EXECUTABLE="$CHROME_EXECUTABLE"
    fvm flutter test test/unit/blocks --platform chrome -v
    fvm flutter test test/unit/providers --platform chrome -v
else
    echo "ERROR: chrome or chromedriver was NOT installed"
    exit 1
fi
