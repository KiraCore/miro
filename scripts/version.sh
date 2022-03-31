#!/usr/bin/env bash
set -e
set +x

# This script is used to have a single and consistent way of retreaving version from the source code
VERSION_FILE=./pubspec.yaml
VERSION=$(grep -Fn -m 1 'version: ' $VERSION_FILE | rev | cut -d ":" -f1 | rev | xargs | tr -dc '[:alnum:]\-\.\+' || echo '')
RAW_VERSION=$VERSION

# Script MUST fail if the version could NOT be retreaved
[ -z $VERSION ] && echo "ERROR: SAIFU version was NOT found in the version file '$VERSION_FILE' !" && exit 1

if [[ $VERSION == *+0 ]] ; then
    # Full Release
    VERSION=${VERSION//+/.}
elif [[ $VERSION == *+* ]] ; then
    # Release Candidate
    VERSION=${VERSION//+/-rc.}
fi
#VERSION="lol."
PATHS_COUNT=$(echo "${VERSION}" | tr -cd "." | wc -c)

if [[ $PATHS_COUNT -le 2 ]] ; then
    VERSION="${VERSION}.0"
fi

PATHS_COUNT=$(echo "${VERSION}" | tr -cd "." | wc -c)

if [[ $PATHS_COUNT -ne 3 ]] ; then
    echo "ERROR: Version format specified in the '$VERSION_FILE' file is NOT valid, expected <uint>.<uint>.<uint>+<uint> or <uint>.<uint>.<uint>, but got '$RAW_VERSION'"
    exit 1
else
    echo "v${VERSION}"
fi
