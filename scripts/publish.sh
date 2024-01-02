#!/usr/bin/env bash
set -e
. /etc/profile || echo "WARNING: Failed to load environment variables"
set -x

echo "INFO: Starting package publishing process..."

rm -rfv ./bin
mkdir -p ./bin

cd ./build/web

zip -r ../../bin/html-web-app.zip ./*

# In order to create IPFS release the base href must be set to './' otherwise browser will not be able to find reference files
# To run the page locally on your PC, you might want to change this value to full reference path
sed -i 's/base href="\/"/base href=\".\/\"/' index.html

zip -r ../../bin/ipfs-web-app.zip ./*

