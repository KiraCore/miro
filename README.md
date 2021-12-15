# miro

Miro is a user interface for Kira Network Users to manage their accounts, balance and transfer tokens between different wallets.

## Installation

Use the git to clone [miro](https://github.com/KiraCore/miro) project.

```bash
git clone git@github.com:KiraCore/miro.git
```

## Usage

The project runs on flutter version **2.5.3**. You can
use [fvm](https://fvm.app/docs/getting_started/installation) for easy switching between versions

```bash
# Install and use required flutter version
fvm install 2.5.3
fvm use 2.5.3

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

## Testing

To run Unit Tests / Integration tests

```bash
# Run all Unit Tests
fvm flutter test test/unit --platform chrome

# To run specific Unit Test
fvm flutter test path/to/test.dart --platform chrome
# e.g.
fvm flutter test test/infra/services/api/withdraws_service_test.dart --platform chrome
```

To run UI Integration tests you need [ChromeDriver](https://chromedriver.chromium.org/downloads)
and [Dart Debug Chrome Extension](https://chrome.google.com/webstore/detail/dart-debug-extension/eljbmlghnomdjgdjmbdekegdkbabckhm)
. The project already includes the driver for chrome 96

```bash
# Run command inside /miro/test_driver/driver
./chromedriver96 --port=4444

# Run command in main project directory
fvm flutter drive --driver=test_driver/integration_test.dart --target=integration_test/app_test.dart -d web-server

```

## Contributing

Pull requests are welcome. For major changes, please open an issue first to discuss what you would like to change.
Please make sure to update tests as appropriate.

## [Licence](./LICENSE.md)