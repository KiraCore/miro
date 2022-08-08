# miro
Miro is user interface for KIRA Network to manage accounts, balance and transfer tokens between different wallets.

## Installation
Use git clone to download [miro](https://github.com/KiraCore/miro) project.
```bash
git clone git@github.com:KiraCore/miro.git
```

## Usage
The project runs on flutter version **3.0.5**. You can use [fvm](https://fvm.app/docs/getting_started/installation) 
for easy switching between versions
```bash
# Install and use required flutter version
fvm install 3.0.5
fvm use 3.0.5

# Install required packages in pubspec.yaml
fvm flutter pub get

# Run project in the Chrome browser
fvm flutter run -d chrome --dart-define=FLUTTER_WEB_USE_SKIA=true
# or
fvm flutter run -d chrome
```

To generate config files use
```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

## Tests
To run Unit Tests / Integration tests
```bash
# Run all Unit Tests
fvm flutter test test/unit --platform chrome

# To run specific Unit Test
fvm flutter test path/to/test.dart --platform chrome
# e.g.
fvm flutter test test/infra/services/api/withdraws_service_test.dart --platform chrome
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