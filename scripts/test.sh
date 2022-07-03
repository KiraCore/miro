#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting unit tests..."
CHROME_EXECUTABLE=$(which google-chrome-unstable || which chrome || which google-chrome || which chromium-browser || which chromium)
CHROMEDRIVER_EXECUTABLE=$(which chromedriver || echo "")
CHROMIUM_VERSION=$(timeout 10 $CHROME_EXECUTABLE --version || echo "")
CHROMEDRIVER_VERSION=$(timeout 10 $CHROMEDRIVER_EXECUTABLE --version || echo "")

fvm flutter doctor -v

# This command is essential for all VM environments due to git security policies
git config --global --add safe.directory /usr/lib/flutter

set +x
echo "-----------------------------------------------------"
echo "|             Starting unit testing...              |"
echo "|----------------------------------------------------"
echo "|                      OS: $(uname -a)"
echo "|       CHROME EXECUTABLE: $CHROME_EXECUTABLE"
echo "| CHROMEDRIVER EXECUTABLE: $CHROMEDRIVER_EXECUTABLE"
echo "|        CHROMIUM VERSION: $CHROMIUM_VERSION"
echo "|    CHROMEDRIVER VERSION: $CHROMEDRIVER_VERSION"
echo "-----------------------------------------------------"
set -x

if [ -f /.dockerenv ]; then
    echo "WARNING: This process is running wihtin docker container and requires chromedriver"

    # NOTE: Some of the tests in the 'test/unit' require UI and fail without it, the chromedriver is essential to execute them
    for file in $(find ./test/unit -name '*.dart'); do
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
            fvm flutter drive --driver=test_driver/integration_test.dart --target=$file -d web-server --release --verbose || SUCCESS=false
        else
            bash-utils echoInfo "INFO: Executing unit test: $file"
            fvm flutter test $file -v || SUCCESS=false
        fi

        if [ "$SUCCESS" == "true" ] ; then
            bash-utils echoInfo "INFO: Passed test '$file'" && continue
        else
            bash-utils echoErr "ERROR: Failed test: '$file'" && break
        fi
    done
else
    fvm flutter test test/unit --platform chrome -v
fi

set +x
echo "----------------------------------------------------"
echo "|           Finished unit testing                  |"
echo "|---------------------------------------------------"
set -x