# KIRA miro
KIRA miro is a user interface for the KIRA Network, allowing to view and manage accounts, transfer tokens between different wallets and explore the network.

_NOTE: All scripts in this repository are only intended to be run on Ubuntu 20.04.4 LTS._

The project runs on flutter version **2.5.3** and requires [fvm](https://fvm.app/docs/getting_started/installation) to allow easy version changes without impacting host environment. If your host machine is not running ubuntu, you can still run all the commands below inside the docker container which contains `dart`, `flutter`, `fvm` and all other essential dependencies that you might need. So no need to install anything and you are ready to go :)

### 1. Download Repository
```bash
git clone git@github.com:KiraCore/miro.git -b "branch-name"

# optionally start docker
make docker-start
cd /miro
# run commands 2., 3. ...
...
exit
make docker-stop
```

### 2. Build 
After successful build, you can find `index.html` in `/miro/build/` directory
```bash
make build
```

### 3. Publish
Used to create release a self contained `zip` file
```bash
make publish
```

### Run project in the Chrome browser
```bash
# Run project in the Chrome browser
fvm flutter run -d chrome --dart-define=FLUTTER_WEB_USE_SKIA=true
# or
fvm flutter run -d chrome
```

### Generating Config Files
```bash
fvm flutter pub run build_runner watch --delete-conflicting-outputs
```

### Running Unit Tests
```bash
# Run all Unit Tests
make test

# To run specific Unit Test
fvm flutter test path/to-file-or-directory/test.dart --platform chrome
```

### Running Local Integration Tests
This command starts an instance of the KIRA Network, runs all Local Integration Tests & stops the local network after finalizing. It is recommended that you use DOCKER container rather then running this command locally.
```bash
make local-test
```
### Starting & Stopping local KIRA Network 
```bash
# start network
make kira-start

# if you run inside docker you should load environment variables to be able to run sekaid commands
loadGlobEnvs
sekaid status

# purge/destroy network
make kira-stop
```

### Running Unit Tests
```bash
# Stop any running networks, cleanup docker containers, images and any other local resources
make clean
```

### Contributing
Pull requests are welcome. For major changes, please open an issue first to discuss what would like to improve. Please 
make sure to update tests as well.

### License
[GNU AGPLv3](https://choosealicense.com/licenses/agpl-3.0/)