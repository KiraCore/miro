import 'package:intl/intl.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';

class BlockTimeModel {
  final AppConfig _appConfig = globalLocator<AppConfig>();
  final DateTime blockTime;

  BlockTimeModel(this.blockTime);

  factory BlockTimeModel.fromString(String blockTime) {
    return BlockTimeModel(DateTime.parse(blockTime));
  }

  bool isOutdated() {
    return durationSinceBlock.inMinutes > _appConfig.outdatedBlockDuration.inMinutes;
  }

  Duration get durationSinceBlock => DateTime.now().difference(blockTime);

  @override
  String toString() {
    return DateFormat('HH:mm dd.MM.yyyy').format(blockTime.toLocal());
  }
}
