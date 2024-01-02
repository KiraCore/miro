#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

BASE_IMAGE_VERSION="v0.10.9"
docker ps -a | awk '{ print $1,$2 }' | grep "ghcr.io/kiracore/docker/base-image:$BASE_IMAGE_VERSION" | awk '{print $1 }' | xargs -I {} docker rm {} || \
 ( echo "WARNING: Failed to delete all containers" && sleep 3 )

docker rmi ghcr.io/kiracore/docker/base-image:$BASE_IMAGE_VERSION || \
 ( echo "WARNING: Failed to delete all images" && sleep 3 )
