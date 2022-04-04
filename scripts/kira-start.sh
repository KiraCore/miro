#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

SEKAI_VERSION="v0.1.24-rc.8"
INTERX_VERSION="v0.4.2-rc.1"

TOOLS_VERSION="v0.0.8.0"
NETWORK_NAME="localnet-0"

##############################################################################################################
# NOTE: For the purpouse of reproductibiliity of the integration tests the addresses must be predefined
# WARNING: IT IS UNSAFE TO USE ANY OF THE MNEMONICS BELOW, OR FOR THE FACT ANY OF THE MNEMONICS FOUND ONLIE!!!
TEST_VALIDATOR_ADDR="kira1r3umx3sa4xzpgvuc2krfff6jyw8ahdy8jsmgcn",
TEST_VALIDATOR_MNEMONIC="name panel sausage upset garbage soccer focus afford pride village guitar brother soul brick twist ivory word crazy lunar ladder razor reveal family pluck"
TEST_FAUCET_ADDR="kira19wsrn0p5yw6rnm25n69x0taxthkrjv6keqvqf4"
TEST_FAUCET_MNEMONIC="cook floor force divert just season style dash skull museum program rifle dial saddle wisdom version color picnic crouch strategy spin gasp live popular"
TEST_USER_1_ADDR="kira1h3qs0zhgnf8jl6rc0r9wfvgk6t75wy3870s7d4"
TEST_USER_1_MNEMONIC="avocado evoke lab thank buzz season scare ask furnace wait episode wood scare canal badge actor feature giant only fancy eyebrow alien neither cancel"
TEST_USER_2_ADDR="kira1uwu8200m3ajp6glpep2nvnfgd0a32000fqwqgg"
TEST_USER_2_MNEMONIC="van front describe cat fatigue brush february awesome woman twin paper rubber favorite viable panic warfare slogan member science rail what grass retire future"
TEST_USER_3_ADDR="kira1hul8dpj4hl29llt4v5w8p8rwlymjh0vckfwpcz"
TEST_USER_3_MNEMONIC="either wasp emerge portion reward deposit switch suspect furnace bacon category panic tray size round top acoustic shop fever better ostrich horror burst harbor"
##############################################################################################################

WORKING_DIRECTORY="$PWD"
ARCH=$(getArch)
OS_VERSION=$(uname) && OS_VERSION="${OS_VERSION,,}"
SEKAI_VERSION_CURRENT=$(sekaid version || echo "")
INTERX_VERSION_CURRENT=$(interx version || echo "")
UTILS_VER=$(utilsVersion 2> /dev/null || echo "")
UTILS_OLD_VER="false" && [[ $(versionToNumber "$UTILS_VER" || echo "0") -ge $(versionToNumber "v0.1.0.0" || echo "1") ]] || UTILS_OLD_VER="true" 

( [ "$ARCH" != "amd64" ] && [ "$ARCH" != "arm64" ] ) && echo "ERROR: Unsupported system architecture '$ARCH'" && exit 1
( [ "$OS_VERSION" != "windows" ] && [ "$OS_VERSION" != "linux" ] && [ "$OS_VERSION" != "darwin" ] ) && echo "ERROR: Unsupported operting system '$OS_VERSION'" && exit 1

echo "INFO: Ensuring essential dependencies are installed & up to date"
cd /tmp

if [ "$UTILS_OLD_VER" == "true" ] ; then
    wget "https://github.com/KiraCore/tools/releases/download/$TOOLS_VERSION/kira-utils.sh" -O ./utils.sh && \
        FILE_HASH=$(sha256sum ./utils.sh | awk '{ print $1 }' | xargs || echo -n "") && \
        [ "$FILE_HASH" == "1cfb806eec03956319668b0a4f02f2fcc956ed9800070cda1870decfe2e6206e" ] && \
        chmod 555 ./utils.sh && ./utils.sh utilsSetup ./utils.sh "/var/kiraglob" && . /etc/profile
else
    echoInfo "INFO: KIRA utils are up to date, latest version $UTILS_VER" && sleep 2
fi

# Essential tool to provide SYSTEMD replacement on OS that might NOT have it mounted such as WSL2 and Docker
SYSCTRL_DESTINATION=/usr/local/bin/systemctl2
if [ ! -f $SYSCTRL_DESTINATION ] ; then
    safeWget /usr/local/bin/systemctl2 \
     https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/9cbe1a00eb4bdac6ff05b96ca34ec9ed3d8fc06c/files/docker/systemctl.py \
     "e02e90c6de6cd68062dadcc6a20078c34b19582be0baf93ffa7d41f5ef0a1fdd" && \
     chmod +x $SYSCTRL_DESTINATION && \
    systemctl2 --version
fi

if [ -z "$KIRA_BIN" ] ; then
    KIRA_BIN="/usr/kira/bin" && setGlobEnv KIRA_BIN $KIRA_BIN && setGlobPath $KIRA_BIN && loadGlobEnvs
    mkdir -p $KIRA_BIN
fi

if [ "$SEKAI_VERSION_CURRENT" != "$SEKAI_VERSION" ] ; then
    echoWarn "WARNING: New version of sekaid MUST be installed, version '$SEKAI_VERSION_CURRENT' is obsolete, expevted '$SEKAI_VERSION'" && sleep 3
    DEB_FILE=sekai-${OS_VERSION}-${ARCH}.deb && rm -frv ./$DEB_FILE ./sekaid && \
        wget https://github.com/KiraCore/sekai/releases/download/${SEKAI_VERSION}/$DEB_FILE && \
        dpkg-deb -x ./$DEB_FILE ./sekaid && \
        cp -fv ./sekaid/bin/sekaid $KIRA_BIN/sekaid
    
    chmod 555 $KIRA_BIN/sekaid
    sekaid version

    SEKAI_UTILS_FILE="sekai-utils.sh" && rm -fv ./$SEKAI_UTILS_FILE && \
    wget https://github.com/KiraCore/sekai/releases/download/${SEKAI_VERSION}/$SEKAI_UTILS_FILE && \
        chmod 555 ./$SEKAI_UTILS_FILE && ./$SEKAI_UTILS_FILE sekaiUtilsSetup && . /etc/profile

    sekaiUtilsVersion
else
    echoInfo "INFO: Sekai '$SEKAI_VERSION_CURRENT' is up to date, no need to install"
fi

if [ "$INTERX_VERSION_CURRENT" != "$INTERX_VERSION" ] ; then
    echoWarn "WARNING: New version of interx MUST be installed, version '$INTERX_VERSION_CURRENT' is obsolete, expevted '$INTERX_VERSION'" && sleep 3
    DEB_FILE=interx-${OS_VERSION}-${ARCH}.deb && rm -frv ./$DEB_FILE ./interx && \
     wget https://github.com/KiraCore/interx/releases/download/${INTERX_VERSION}/$DEB_FILE && \
     cp -fv $DEB_FILE $KIRA_BIN/interx && \
     dpkg-deb -x ./$DEB_FILE ./interx && \
     cp -fv ./interx/bin/interx $KIRA_BIN/interx

     chmod 555 $KIRA_BIN/interx
     interx version
else
    echoInfo "INFO: Interx '$SEKAI_VERSION_CURRENT' is up to date, no need to install"
fi

cd $WORKING_DIRECTORY

echoInfo "INFO: Environment cleanup...."
./scripts/kira-stop.sh

echoInfo "INFO: Environment setup..."
setGlobEnv SEKAID_HOME ~/.sekaid-local
setGlobEnv INTERX_HOME ~/.interx-local
setGlobEnv NETWORK_NAME $NETWORK_NAME
setGlobEnv TEST_VALIDATOR_ADDR $TEST_VALIDATOR_ADDR
setGlobEnv TEST_FAUCET_ADDR $TEST_FAUCET_ADDR
setGlobEnv TEST_USER_1_ADDR $TEST_USER_1_ADDR
setGlobEnv TEST_USER_2_ADDR $TEST_USER_2_ADDR
setGlobEnv TEST_USER_3_ADDR $TEST_USER_3_ADDR
loadGlobEnvs

mkdir -p "$SEKAID_HOME" "$INTERX_HOME"

echoInfo "INFO: Starting new network..."
sekaid init --overwrite --chain-id=$NETWORK_NAME "KIRA TEST LOCAL VALIDATOR NODE 1" --home=$SEKAID_HOME
recoverAccount validator "$TEST_VALIDATOR_MNEMONIC"
recoverAccount faucet "$TEST_FAUCET_MNEMONIC"
sekaid add-genesis-account $(showAddress validator) 150000000000000ukex,150000000000000test,2000000000000000000000000000samolean,1000000lol --keyring-backend=test --home=$SEKAID_HOME
sekaid add-genesis-account $(showAddress faucet) 150000000000000ukex,150000000000000test,2000000000000000000000000000samolean,1000000lol --keyring-backend=test --home=$SEKAID_HOME
sekaid gentx-claim validator --keyring-backend=test --moniker="GENESIS VALIDATOR" --home=$SEKAID_HOME

cat > /etc/systemd/system/sekai.service << EOL
[Unit]
Description=Local SEKAI Node
After=network.target
[Service]
MemorySwapMax=0
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$KIRA_BIN/sekaid start --home=$SEKAID_HOME --trace
Restart=always
RestartSec=5
LimitNOFILE=4096
[Install]
WantedBy=default.target
EOL

chmod 777 "$SEKAID_HOME"

systemctl2 enable sekai 
systemctl2 start sekai || ( journalctl -u sekai.service -b --no-pager -n 50 && exit 1 ) 

echoInfo "INFO: Waiting for network to start..." && sleep 3

systemctl2 status sekai

echoInfo "INFO: Checking network status..."
NETWORK_STATUS_CHAIN_ID=$(showStatus | jq .NodeInfo.network | xargs)

if [ "$NETWORK_NAME" != "$NETWORK_STATUS_CHAIN_ID" ] ; then
    echoErr "ERROR: Incorrect chain ID from the status query, expected '$NETWORK_NAME', but got $NETWORK_STATUS_CHAIN_ID"
fi

BLOCK_HEIGHT=$(showBlockHeight)
echoInfo "INFO: Waiting for next block to be produced..." && sleep 10
NEXT_BLOCK_HEIGHT=$(showBlockHeight)

if [ $BLOCK_HEIGHT -ge $NEXT_BLOCK_HEIGHT ] ; then
    echoErr "ERROR: Failed to produce next block height, stuck at $BLOCK_HEIGHT"
else 
    echoInfo "INFO: Success SEKAI is up and running, block production started!"
fi

echoInfo "INFO: Setting up interx..."

interx init --home=$INTERX_HOME

cat > /etc/systemd/system/interx.service << EOL
[Unit]
Description=Local INTERX Node
After=network.target
[Service]
MemorySwapMax=0
Type=simple
User=root
WorkingDirectory=/root
ExecStart=$KIRA_BIN/interx start --home=$INTERX_HOME
Restart=always
RestartSec=5
LimitNOFILE=4096
[Install]
WantedBy=default.target
EOL

chmod 777 "$INTERX_HOME"

systemctl2 enable interx 
systemctl2 start interx

echoInfo "INFO: Waiting for interx to start..." && sleep 3

systemctl2 status interx

INTEREX_CHAIN_ID=$(curl -s localhost:11000/api/status | jq .node_info.network | xargs || echo "null")
INTEREX_CHAIN_HEIGHT=$(curl -s localhost:11000/api/status | jq .interx_info.latest_block_height | xargs || echo "0")


if [ "$INTEREX_CHAIN_ID" != "$NETWORK_NAME" ] ; then
    echoErr "ERROR: Failed to start INTERX, inconsistent chain id, expected '$NETWORK_NAME', but got '$INTEREX_CHAIN_ID'"
    exit 1
fi

if [ "$INTEREX_CHAIN_HEIGHT" == "0" ] || [[ $INTEREX_CHAIN_HEIGHT -lt $SEKAI_CHAIN_HEIGHT ]]; then
    echoErr "ERROR: Failed to start INTERX, inconsistent block height, expected no less than '$NEXT_BLOCK_HEIGHT', but got '$INTEREX_CHAIN_HEIGHT'"
    exit 1
fi

echoInfo "INFO: Success, INTERX is up and running!"

echoInfo "INFO: Setting up TEST USER account and transfering tokens..."

recoverAccount user1 "$TEST_USER_1_MNEMONIC"
recoverAccount user2 "$TEST_USER_2_MNEMONIC"
recoverAccount user3 "$TEST_USER_3_MNEMONIC"

# send 10'000 KEX from faucet to user1,2,3
sendTokens faucet $(showAddress user1) 1000000000000 ukex 100 ukex
sendTokens faucet $(showAddress user2) 1000000000000 ukex 100 ukex
sendTokens faucet $(showAddress user3) 1000000000000 ukex 100 ukex

sendTokens user3 $(showAddress user1) 1000000 ukex 100 ukex
sendTokens user2 $(showAddress user1) 2000000 ukex 100 ukex
sendTokens user1 $(showAddress user1) 3000000 ukex 100 ukex

echoInfo "INFO: Setting up token aliases"

sekaid tx tokens proposal-upsert-alias --from validator --keyring-backend=test \
 --symbol="KEX" \
 --name="KIRA" \
 --icon="http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/kex.svg" \
 --decimals=6 \
 --denoms="ukex" \
 --title="Upsert KEX icon URL link" \
 --description="Local Test Setup From KIRA Manager" \
 --chain-id=$NETWORK_NAME --fees=100ukex --yes --broadcast-mode=async --output=json --home=$SEKAID_HOME | txAwait 180

sekaid tx tokens proposal-upsert-alias --from validator --keyring-backend=test \
 --symbol="TEST" \
 --name="Test TestCoin" \
 --icon="http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/test.svg" \
 --decimals=8 \
 --denoms="test" \
 --title="Upsert Test TestCoin icon URL link" \
 --description="Initial Setup From KIRA Manager" \
 --chain-id=$NETWORK_NAME --fees=100ukex --yes --broadcast-mode=async --output=json --home=$SEKAID_HOME | txAwait 180

sekaid tx tokens proposal-upsert-alias --from validator --keyring-backend=test \
 --symbol="SAMO" \
 --name="Samolean TestCoin" \
 --icon="http://kira-network.s3-eu-west-1.amazonaws.com/assets/img/tokens/samolean.svg" \
 --decimals=18 \
 --denoms="samolean" \
 --title="Upsert Samolean TestCoin icon URL link" \
 --description="Initial Setup From KIRA Manager" \
 --chain-id=$NETWORK_NAME --fees=100ukex --yes --broadcast-mode=async --output=json --home=$SEKAID_HOME | txAwait 180

# TODO: Setup token rates
#setTokenRate validator "samolean" "0.25" "true"

echoInfo "INFO: Setting up identity records"

upsertIdentityRecord user1 "username" "user-1" 180
upsertIdentityRecord user2 "username" "user-2" 180
upsertIdentityRecord user3 "username" "user-3" 180

echoInfo "INFO: Test network setup ended"
