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

fvm flutter doctor -v

# This command is essential for all VM environments due to git security policies
git config --global --add safe.directory /usr/lib/flutter

set +x
echo "-----------------------------------------------------"
echo "|          Starting integration testing...          |"
echo "|----------------------------------------------------"
echo "|                      OS: $(uname -a)"
echo "|       CHROME EXECUTABLE: $CHROME_EXECUTABLE"
echo "| CHROMEDRIVER EXECUTABLE: $CHROMEDRIVER_EXECUTABLE"
echo "|        CHROMIUM VERSION: $CHROMIUM_VERSION"
echo "|    CHROMEDRIVER VERSION: $CHROMEDRIVER_VERSION"
echo "-----------------------------------------------------"
set -x

# NOTE: This is just a single integration test example, all tests MUST be added and test files updated to contain relevant 
TEST_SUCCESS="true"
./scripts/kira-start.sh

bash-utils loadGlobEnvs

if [ -f /.dockerenv ]; then
    echoInfo "INFO: Process is running inside docker container, external chromedriver must be used to execute browser related tests!"
    for file in $(find ./test/integration -name '*.dart'); do
        SUCCESS=true
        if grep -q "integration_test.dart" "$file"; then
            bash-utils echoInfo "INFO: Executing integration test: $file"

            # NOTE: For integration tests to work (within docker), dbus & chromedriver must be restarted every time
            echo "INFO: Restarting chromedriver"
            service dbus stop || echo "WARNINIG: Failed to stop dbus"
            systemctl stop chromedriver || echo "WARNINIG: Failed to stop chromedriver service"
            service dbus start || echo "WARNINIG: Failed to start dbus"
            systemctl start chromedriver || echo "WARNINIG: Failed to restart chromedriver service"

            echo "INFO: Checking chromedriver status"
            # NOTE: Using 'jsonParse' to ensure that the resulting output has a correct json format
            curl --show-error --fail localhost:4444/status | bash-utils jsonParse ".value" | jq

            ## NOTE:The --release flag is essential for running browser dependent tests in UI, see https://github.com/jonsamwell/flutter_gherkin/issues/66
            ## each browser dependent test requires: `import 'package:integration_test/integration_test.dart';`
            ## as well as: `IntegrationTestWidgetsFlutterBinding.ensureInitialized();` in the first line of the main function
            ## for the browser dependent tests reference see: https://docs.flutter.dev/cookbook/testing/integration/introduction#4-write-the-integration-test
            fvm flutter drive --driver=test_driver/integration_test.dart --target=$file -d web-server --release --verbose \
             --dart-define=TEST_INTERX_URL="127.0.0.1:11000" \
             --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" || SUCCESS=false
        else
            bash-utils echoWarn "WARNING: Integration test '$file' is NOT supported! To support new tests add 'import 'package:integration_test/integration_test.dart' as well as: 'IntegrationTestWidgetsFlutterBinding.ensureInitialized();' in the first line of the main function!"
        fi

        if [ "$SUCCESS" == "true" ] ; then
            bash-utils echoInfo "INFO: Passed test '$file'" && continue
        else
            bash-utils echoErr "ERROR: Failed test: '$file'"
            TEST_SUCCESS="false" && break
        fi
    done
else
    export CHROME_EXECUTABLE="$CHROME_EXECUTABLE"

    for file in $(find ./test/integration -name '*.dart'); do
        SUCCESS=true
        if grep -q "integration_test.dart" "$file"; then
            bash-utils echoInfo "INFO: Executing integration test: $file"

            fvm flutter test $file --platform chrome \
             --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR" || SUCCESS="false"
        else
            bash-utils echoWarn "WARNING: Integration test '$file' is NOT supported! To support new tests add 'import 'package:integration_test/integration_test.dart' as well as: 'IntegrationTestWidgetsFlutterBinding.ensureInitialized();' in the first line of the main function!"
        fi

        if [ "$SUCCESS" == "true" ] ; then
            bash-utils echoInfo "INFO: Passed test '$file'" && continue
        else
            bash-utils echoErr "ERROR: Failed test: '$file'"
            TEST_SUCCESS="false" && break
        fi
    done
fi

# Regardless if tests pass or not, the infrastructure will be stopped
./scripts/kira-stop.sh
if [ "$TEST_SUCCESS" == "false" ] ; then
    echo "ERROR: Local Integration Tests failed, see output logs."
    exit 1
else
    echo "INFO: Success, local tests finished"
fi

set +x
echo "----------------------------------------------------"
echo "|        Finished integration testing              |"
echo "|---------------------------------------------------"
set -x