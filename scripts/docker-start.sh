#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

BASE_IMAGE_VERSION="v0.10.9"
CONTAINER=$(docker ps -a | awk '{ print $1,$2 }' | grep -m 1 "ghcr.io/kiracore/docker/base-image:$BASE_IMAGE_VERSION" | awk '{print $1 }' || echo "")

if [ ! -z "$CONTAINER" ] ; then
    docker start -i $CONTAINER
else
    docker run -i -t --privileged --net host --mount src="$(pwd)",target=/miro,type=bind ghcr.io/kiracore/docker/base-image:$BASE_IMAGE_VERSION /bin/bash
fi
