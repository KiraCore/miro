#!/bin/bash
sudo apt-get update
sudo apt-get install git apt-transport-https
git clone https://github.com/KiraCore/miro.git
cd miro
#git checkout dev
sudo sh -c 'wget -qO- https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -'
sudo sh -c 'wget -qO- https://storage.googleapis.com/download.dartlang.org/linux/debian/dart_stable.list > /etc/apt/sources.list.d/dart_stable.list'
sudo apt-get update
sudo apt-get install dart
export PATH="$PATH:/usr/lib/dart/bin"
export PATH="$PATH:$HOME/.pub-cache/bin"
export PATH="$PATH:./.fvm/flutter_sdk"
dart pub global activate fvm
fvm install 3.13.6
fvm use 3.13.6
fvm flutter build web