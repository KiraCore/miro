#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

BASE_IMAGE_VERSION="v0.10.2-rc.9"
CONTAINER=$(docker ps -a | awk '{ print $1,$2 }' | grep -m 1 "ghcr.io/kiracore/docker/base-image:$BASE_IMAGE_VERSION" | awk '{print $1 }' || echo "")

if [ ! -z "$CONTAINER" ] ; then
    docker stop $CONTAINER || echo "WARNING: Could not stop container '$CONTAINER'"
else
    echo "WARNING: No containers to stop"
fi
