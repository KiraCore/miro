#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting local integration tests..."

uname -a
CHROME_EXECUTABLE=$(which google-chrome || which chrome || which chromium-browser || which chromium)
CHROMIUM_VERSION=$($CHROME_EXECUTABLE --version || echo "")

# # NOTE: Might be good to use a web-server for the integration tests
# # In such case ensure that 'chromedriver --port=4444' is running as systemd service or a background process
# systemctl2 enable chromedriver 
# systemctl2 start chromedriver || ( journalctl -u chromedriver.service -b --no-pager -n 50 && exit 1 ) 

if [ ! -z "$CHROMIUM_VERSION" ] ; then
    export CHROME_EXECUTABLE="$CHROME_EXECUTABLE"
    ./scripts/kira-start.sh

    # NOTE: This is just a single integration test, all tests MUST be added and updated!
    TEST_SUCCESS="true"

    fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome \
     --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" || TEST_SUCCESS="false"

    # # Alternative integration test execution example with web-server (requires chromedriver)
    # fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome -d web-server \
    # --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" || TEST_SUCCESS="false"

    # Regardless if tests pass or not, the infrastructure will be stopped
    ./scripts/kira-stop.sh
    if [ "$TEST_SUCCESS" == "false" ] ; then
        echo "ERROR: Local Integration Tests failed, see output logs."
        exit 1
    else
        echo "INFO: Success, local tests finished"
    fi
else
    echo "ERROR: chrome or chromium must be installed and added to your PATH!"
    echo "INFO: Reccomended solution: 'add-apt-repository -y ppa:saiarcot895/chromium-de && apt install -y chromium-browser'"
    exit 1
fi
