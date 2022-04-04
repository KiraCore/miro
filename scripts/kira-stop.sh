#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echoInfo "INFO: Environment cleanup...."
systemctl2 stop sekai || echoWarn "WARNING: sekai service was NOT running or could NOT be stopped"
systemctl2 stop interx || echoWarn "WARNING: interx service was NOT running or could NOT be stopped"

kill -9 $(sudo lsof -t -i:9090) || echoWarn "WARNING: Nothing running on port 9090, or failed to kill processes"
kill -9 $(sudo lsof -t -i:6060) || echoWarn "WARNING: Nothing running on port 6060, or failed to kill processes"
kill -9 $(sudo lsof -t -i:26656) || echoWarn "WARNING: Nothing running on port 26656, or failed to kill processes"
kill -9 $(sudo lsof -t -i:26657) || echoWarn "WARNING: Nothing running on port 26657, or failed to kill processes"
kill -9 $(sudo lsof -t -i:26658) || echoWarn "WARNING: Nothing running on port 26658, or failed to kill processes"
kill -9 $(sudo lsof -t -i:11000) || echoWarn "WARNING: Nothing running on port 11000, or failed to kill processes"

rm -rfv "$SEKAID_HOME" "${GOBIN}/sekaid" /etc/systemd/system/sekai.service || echoWarn "WARNING: Failed to cleanup files after sekai"
rm -rfv "$INTERX_HOME" "${GOBIN}/interx" /etc/systemd/system/interx.service  || echoWarn "WARNING: Failed to cleanup files after interx"
echoInfo "INFO: Finished KIRA Network Environment cleanup."