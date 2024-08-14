# miro

Miro is user interface for KIRA Network to manage accounts, balance and transfer tokens between different wallets.

## Installation

Use git clone to download [miro](https://github.com/KiraCore/miro) project.

```bash
git clone git@github.com:KiraCore/miro.git
```

## Usage

The project runs on flutter version **3.16.9**. You can
use [fvm](https://fvm.app/documentation/getting-started/installation)
for easy switching between versions

```bash
# Install and use required flutter version
fvm install 3.16.9
fvm use 3.16.9

# Install required packages in pubspec.yaml
fvm flutter pub get

# Run project in the Chrome browser
fvm flutter run -d chrome
# or
fvm flutter run -d web-server
```

To generate config files use

```bash
fvm flutter pub run build_runner
```

```bash
# Built-in Commands 
# - build: Runs a single build and exits.
# - watch: Runs a persistent build server that watches the files system for edits and does rebuilds as necessary
# - serve: Same as watch, but runs a development server as well

# Command Line Options
# --delete-conflicting-outputs: Assume conflicting outputs in the users package are from previous builds, and skip the user prompt that would usually be provided.
# 
# Command example:

fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Tests

To run Unit Tests / Integration tests

```bash
# Run all Unit Tests
fvm flutter test test/unit --platform chrome --null-assertions

# Run all Integration Tests
fvm flutter test test/integration --platform chrome --null-assertions

# Run specific test
fvm flutter test path/to/test.dart --platform chrome --null-assertions

# Command example:
fvm flutter test test/unit/infra/services/api_kira/query_execution_fee_service_test.dart --platform chrome --null-assertions
```

## Building, Deploying and Installing

To build project please run script in [deploy.sh](https://github.com/KiraCore/miro/deploy.sh). \
Deploy script is only intended to be run on Ubuntu 20.04.4 LTS.\
After successful build, open index.html in "/miro/build/web".\
Enjoy!

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what would like to improve. Please
make sure to update tests as well.

## [Licence](./LICENSE.md)