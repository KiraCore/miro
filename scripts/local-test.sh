#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting local integration tests..."

uname -a
CHROME_EXECUTABLE=$(which google-chrome-unstable || which chrome || which google-chrome || which chromium-browser || which chromium)
CHROMEDRIVER_EXECUTABLE=$(which chromedriver || echo "")
CHROMIUM_VERSION=$($CHROME_EXECUTABLE --version || echo "")
CHROMEDRIVER_VERSION=$($CHROMEDRIVER_EXECUTABLE --version || echo "")


# NOTE: This is just a single integration test example, all tests MUST be added and test files updated to contain relevant 
TEST_SUCCESS="true"
./scripts/kira-start.sh

# fvm flutter run -d web-server -v --debug

if [ ! -z "$CHROMEDRIVER_VERSION" ] ; then
    fvm flutter drive --driver=test_driver/integration_test.dart \
     --target=test/integration/infra/services/api/deposits_service_test.dart \
     --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" \
     -d web-server --release

elif [ ! -z "$CHROMIUM_VERSION" ] ; then
    export CHROME_EXECUTABLE="$CHROME_EXECUTABLE"

    fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome \
     --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" || TEST_SUCCESS="false"

     fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome \
     --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" -d web-server
else
    # Regardless if tests pass or not, the infrastructure will be stopped
    ./scripts/kira-stop.sh || echo "WARNINIG: Failed to stop sekai & interx"
    echo "ERROR: chrome or chromedriver must be installed!"
    exit 1
fi

# Regardless if tests pass or not, the infrastructure will be stopped
./scripts/kira-stop.sh
if [ "$TEST_SUCCESS" == "false" ] ; then
    echo "ERROR: Local Integration Tests failed, see output logs."
    exit 1
else
    echo "INFO: Success, local tests finished"
fi
