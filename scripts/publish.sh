#!/usr/bin/env bash
set -e
set -x

echo "INFO: Starting package publishing process..."

rm -rfv ./bin
mkdir -p ./bin

cd ./build/web

zip -r ../../bin/html-web-app.zip ./*
