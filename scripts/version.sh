#!/usr/bin/env bash
set -e
set +x

# This script is used to have a single and consistent way of retreaving version from the source code
VERSION_FILE=./pubspec.yaml
VERSION=$(grep -Fn -m 1 'version: ' $VERSION_FILE | rev | cut -d ":" -f1 | rev | xargs | tr -dc '[:alnum:]\-\.\+' || echo '')
RAW_VERSION=$VERSION

# Script MUST fail if the version could NOT be retreaved
[ -z $VERSION ] && echo "ERROR: MIRO version was NOT found in the version file '$VERSION_FILE' !" && exit 1

PATHS_COUNT=$(echo "${VERSION}" | tr -cd "." | wc -c)

if [[ $PATHS_COUNT -lt 2 ]] ; then
    echo "ERROR: Version has invalid format, must by X.X.X, X.X.X.X, X.X.X+X, X.X.X-rc.X, but got $RAW_VERSION"
fi

VERSION=${VERSION//+/.}
VERSION=$(echo "$VERSION" | grep -o '[^-]*$')

if [[ $PATHS_COUNT -le 2 ]] ; then
    VERSION="${VERSION}.0"
fi

major_VERSION=$(echo $VERSION | cut -d. -f1 | sed 's/[^0-9]*//g')
minor_VERSION=$(echo $VERSION | cut -d. -f2 | sed 's/[^0-9]*//g')
micro_VERSION=$(echo $VERSION | cut -d. -f3 | sed 's/[^0-9]*//g')
build_VERSION=$(echo $VERSION | cut -d. -f4 | sed 's/[^0-9]*//g')

if [[ $micro_VERSION -gt 0 ]] ; then
    echo "v${major_VERSION}.${minor_VERSION}.${micro_VERSION}-rc.${build_VERSION}"
else
    echo "v${major_VERSION}.${minor_VERSION}.${micro_VERSION}.${build_VERSION}"
fi
