import 'package:miro/shared/utils/app_logger.dart';

class AppConfig {
  static List<String> supportedInterxVersions = <String>['v0.4.11'];
  static const int bulkSinglePageSize = 500;

  static bool isInterxVersionSupported(String version) {
    bool supportStatus = supportedInterxVersions.contains(version);
    if (!supportStatus) {
      AppLogger().log(message: 'Interx version [$version] is not supported', logLevel: LogLevel.warning);
    }
    return supportStatus;
  }
}
