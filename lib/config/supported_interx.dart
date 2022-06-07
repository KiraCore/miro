import 'package:miro/shared/utils/app_logger.dart';

class SupportedInterx {
  static List<String> supportedVersions = <String>['localnet-1'];

  static bool isSupported(String version) {
    bool supportStatus = supportedVersions.contains(version);
    if (!supportStatus) {
      AppLogger().log(message: 'Interx version [$version] is not supported', logLevel: LogLevel.warning);
    }
    return supportStatus;
  }
}
