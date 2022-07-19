import 'package:intl/intl.dart';

class BlockTimeModel {
  final DateTime blockTime;

  BlockTimeModel({
    required this.blockTime,
  });

  factory BlockTimeModel.fromString(String blockTime) {
    return BlockTimeModel(
      blockTime: DateTime.parse(blockTime),
    );
  }

  bool isOutdated() {
    return durationSinceBlock.inMinutes > 5;
  }

  Duration get durationSinceBlock => DateTime.now().difference(blockTime);

  @override
  String toString() {
    return DateFormat('HH:mm dd.MM.yyyy').format(blockTime.toLocal());
  }
}
