# Dev on Windows 10

```
# Open Ubuntu 20.04 WSL 2.0 console

sudo -s

ARCHITECTURE=$(uname -m)
OS_VERSION=$(uname) && OS_VERSION="${OS_VERSION,,}"
FLUTTER_CHANNEL="stable"
FLUTTER_VERSION="2.10.3-$FLUTTER_CHANNEL"
DART_CHANNEL_PATH="stable/release"
DART_VERSION="2.16.1"
TOOLS_VERSION="v0.0.8.0"

# Install Essential Dependencies

echo "Starting core dependency build..."
apt-get update -y
apt-get install -y --allow-unauthenticated --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    software-properties-common curl wget git nginx apt-transport-https jq

echo "INFO: Installing kira-utils..."
wget "https://github.com/KiraCore/tools/releases/download/$TOOLS_VERSION/kira-utils.sh" -O ./utils.sh && \
    FILE_HASH=$(sha256sum ./utils.sh | awk '{ print $1 }' | xargs || echo -n "") && \
    [ "$FILE_HASH" == "1cfb806eec03956319668b0a4f02f2fcc956ed9800070cda1870decfe2e6206e" ] && \
    chmod -v 555 ./utils.sh && ./utils.sh utilsSetup ./utils.sh "/var/kiraglob" && . /etc/profile

if [ "$(getArch)" == "arm64" ] ; then
    DART_ARCH="arm64"
    DART_EXPECTED_HASH="de9d1c528367f83bbd192bd565af5b7d9d48f76f79baa4c0e4cf64723e3fb8be"
    FLUTTER_EXPECTED_HASH="7e2a28d14d7356a5bbfe516f8a7c9fc0353f85fe69e5cf6af22be2c7c8b45566"
elif [ "$(getArch)" == "amd64" ] ; then
    DART_ARCH="x64"
    DART_EXPECTED_HASH="3cc63a0c21500bc5eb9671733843dcc20040b39fdc02f35defcf7af59f88d459"
    FLUTTER_EXPECTED_HASH="7e2a28d14d7356a5bbfe516f8a7c9fc0353f85fe69e5cf6af22be2c7c8b45566"
else
    echoErr "ERROR: Uknown architecture $(getArch)"
    exit 1
fi

echoInfo "INFO: Updating dpeendecies (2)..."
apt-get update -y

echoInfo "INFO: Installing core dpeendecies..."
apt-get install -y --allow-unauthenticated --allow-downgrades --allow-remove-essential --allow-change-held-packages \
    file build-essential net-tools hashdeep make ca-certificates p7zip-full lsof libglu1-mesa bash gnupg \
    nodejs node-gyp python python3 python3-pip tar unzip xz-utils yarn zip protobuf-compiler golang-goprotobuf-dev \
    golang-grpc-gateway golang-github-grpc-ecosystem-grpc-gateway-dev clang cmake gcc g++ pkg-config libudev-dev \
    libusb-1.0-0-dev curl iputils-ping nano openssl dos2unix

echoInfo "INFO: Updating dpeendecies (3)..."
apt update -y
apt install -y bc dnsutils psmisc netcat nodejs npm

# install systemd alternative
wget https://raw.githubusercontent.com/gdraheim/docker-systemctl-replacement/master/files/docker/systemctl.py -O /usr/local/bin/systemctl2 && \
 chmod +x /usr/local/bin/systemctl2 && \
 systemctl2 --version

# install deb package manager
echo 'deb [trusted=yes] https://repo.goreleaser.com/apt/ /' | tee /etc/apt/sources.list.d/goreleaser.list && apt-get update -y && \
	apt install nfpm

# setup flutter & dart paths
FLUTTER_ROOT="/usr/lib/flutter" && \
 setGlobPath $FLUTTER_ROOT/bin && \
 setGlobPath $FLUTTER_ROOT/bin/cache/dart-sdk/bin

# install flutter
FLUTTER_TAR="flutter_${OS_VERSION}_$FLUTTER_VERSION.tar.xz" && safeWget $FLUTTER_TAR \
 https://storage.googleapis.com/flutter_infra_release/releases/$FLUTTER_CHANNEL/${OS_VERSION}/$FLUTTER_TAR $FLUTTER_EXPECTED_HASH && \
 mkdir -p /usr/lib &&  tar -C /usr/lib -xvf ./$FLUTTER_TAR && FLUTTER_CACHE=$FLUTTER_ROOT/bin/cache && 
 rm -rfv $FLUTTER_CACHE/dart-sdk && mkdir -p $FLUTTER_CACHE && \
 touch $FLUTTER_CACHE/.dartignore && touch $FLUTTER_CACHE/engine-dart-sdk.stamp

# install dart
DART_ZIP="dartsdk-${OS_VERSION}-$DART_ARCH-release.zip" && safeWget $DART_ZIP \
 https://storage.googleapis.com/dart-archive/channels/$DART_CHANNEL_PATH/$DART_VERSION/sdk/$DART_ZIP $DART_EXPECTED_HASH && \
 unzip ./$DART_ZIP -d $FLUTTER_CACHE

# setup dependencies
loadGlobEnvs && \
 flutter config --enable-web && \
 flutter doctor
 flutter doctor --android-licenses

# setup flutter version management
dart pub global activate fvm

setGlobPath "$HOME/.pub-cache/bin"
loadGlobEnvs

fvm --version

# mount C drive or other disk where repo is stored
setGlobLine "mount -t drvfs C:" "mount -t drvfs C: /mnt/c || echo 'Failed to mount C drive'"

# set env variable to your local repos (will vary depending on the user)
setGlobEnv MIRO_REPO "/mnt/c/Users/asmodat/Desktop/KIRA/GITHUB/miro" && \
 loadGlobEnvs

# Build, Test & publish
cd $MIRO_REPO
make build
```

