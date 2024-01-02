#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

SEKAI_VERSION="v0.2.1-rc.15"
INTERX_VERSION="v0.4.11"
TOOLS_VERSION="v0.2.5-rc.8"
COSIGN_VERSION="v1.7.2"
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
ARCH=$(uname -m) && ( [[ "${ARCH,,}" == *"arm"* ]] || [[ "${ARCH,,}" == *"aarch"* ]] ) && ARCH="arm64" || ARCH="amd64"
PLATFORM=$(uname) && PLATFORM=$(echo "$PLATFORM" | tr '[:upper:]' '[:lower:]')
COSIGN_INSTALLED=$(isCommand cosign &> /dev/null || echo "false")
KIRA_COSIGN_PUB=/usr/keys/kira-cosign.pub && mkdir -p /usr/keys
UTILS_VER=$(utilsVersion 2> /dev/null || echo "")
UTILS_OLD_VER="false" && [[ $(versionToNumber "$UTILS_VER" || echo "0") -ge $(versionToNumber "v0.1.2.4" || echo "1") ]] || UTILS_OLD_VER="true" 

( [ "$PLATFORM" != "windows" ] && [ "$PLATFORM" != "linux" ] && [ "$PLATFORM" != "darwin" ] ) && echo "ERROR: Unsupported operting system '$PLATFORM'" && exit 1

cd /tmp

if [ "$COSIGN_INSTALLED" != "true" ] ; then
    echo "INFO: Installing cosign"
    FILE_NAME=$(echo "cosign-${PLATFORM}-${ARCH}" | tr '[:upper:]' '[:lower:]') && \
        wget https://github.com/sigstore/cosign/releases/download/${COSIGN_VERSION}/$FILE_NAME && chmod +x -v ./$FILE_NAME && \
        mv -fv ./$FILE_NAME /usr/local/bin/cosign && cosign version
fi

cat > $KIRA_COSIGN_PUB << EOL
-----BEGIN PUBLIC KEY-----
MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAE/IrzBQYeMwvKa44/DF/HB7XDpnE+
f+mU9F/Qbfq25bBWV2+NlYMJv3KvKHNtu3Jknt6yizZjUV4b8WGfKBzFYw==
-----END PUBLIC KEY-----
EOL

echo "INFO: Ensuring essential dependencies are installed & up to date"

if [ "$UTILS_OLD_VER" == "true" ] ; then
    FILE_NAME="bash-utils.sh" && \
        wget "https://github.com/KiraCore/tools/releases/download/$TOOLS_VERSION/${FILE_NAME}" -O ./$FILE_NAME && \
        wget "https://github.com/KiraCore/tools/releases/download/$TOOLS_VERSION/${FILE_NAME}.sig" -O ./${FILE_NAME}.sig && \
        cosign verify-blob --key="$KIRA_COSIGN_PUB" --signature=./${FILE_NAME}.sig ./$FILE_NAME && \
        chmod -v 755 ./$FILE_NAME && ./$FILE_NAME bashUtilsSetup "/var/kiraglob" && . /etc/profile && \
        echoInfo "INFO: Installed bash-utils $(bash-utils bashUtilsVersion)"
else
    echoInfo "INFO: KIRA utils are up to date, latest version $UTILS_VER" && sleep 2
fi

ARCH=$(getArch)
( [ "$ARCH" != "amd64" ] && [ "$ARCH" != "arm64" ] ) && echo "ERROR: Unsupported system architecture '$ARCH'" && exit 1

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

cd $KIRA_BIN

BIN_DEST="/usr/local/bin/sekaid" && \
  safeWget ./sekaid.deb "https://github.com/KiraCore/sekai/releases/download/$SEKAI_VERSION/sekai-linux-${ARCH}.deb" \
  "$KIRA_COSIGN_PUB" && dpkg-deb -x ./sekaid.deb ./sekaid && cp -fv "$KIRA_BIN/sekaid/bin/sekaid" $BIN_DEST && chmod -v 755 $BIN_DEST

BIN_DEST="/usr/local/bin/sekai-utils.sh" && \
  safeWget ./sekai-utils.sh "https://github.com/KiraCore/sekai/releases/download/$SEKAI_VERSION/sekai-utils.sh" \
  "$KIRA_COSIGN_PUB" && chmod -v 755 ./sekai-utils.sh && ./sekai-utils.sh sekaiUtilsSetup && . /etc/profile && chmod -v 755 $BIN_DEST

FILE=/usr/local/bin/sekai-env.sh && \
safeWget $FILE "https://github.com/KiraCore/sekai/releases/download/$SEKAI_VERSION/sekai-env.sh" \
  "$KIRA_COSIGN_PUB" && chmod -v 755 $FILE && setGlobLine "source $FILE" "source $FILE"

BIN_DEST="/usr/local/bin/interx" && \
safeWget ./interx.deb "https://github.com/KiraCore/interx/releases/download/$INTERX_VERSION/interx-linux-${ARCH}.deb" \
  "$KIRA_COSIGN_PUB" && dpkg-deb -x ./interx.deb ./interx && cp -fv "$KIRA_BIN/interx/bin/interx" $BIN_DEST && chmod -v 755 $BIN_DEST

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
ExecStart=/usr/local/bin/sekaid start --home=$SEKAID_HOME --trace
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
ExecStart=/usr/local/bin/interx start --home=$INTERX_HOME
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
