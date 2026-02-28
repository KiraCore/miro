import 'package:equatable/equatable.dart';

class SyncInfo extends Equatable {
  final String earliestAppHash;
  final String earliestBlockHash;
  final int earliestBlockHeight;
  final DateTime earliestBlockTime;
  final String latestAppHash;
  final String latestBlockHash;
  final int latestBlockHeight;
  final DateTime latestBlockTime;

  const SyncInfo({
    required this.earliestAppHash,
    required this.earliestBlockHash,
    required this.earliestBlockHeight,
    required this.earliestBlockTime,
    required this.latestAppHash,
    required this.latestBlockHash,
    required this.latestBlockHeight,
    required this.latestBlockTime,
  });

  factory SyncInfo.fromJson(Map<String, dynamic> json) {
    return SyncInfo(
      earliestAppHash: json['earliest_app_hash'] as String,
      earliestBlockHash: json['earliest_block_hash'] as String,
      earliestBlockHeight: int.tryParse(json['earliest_block_height'] as String) ?? 1,
      earliestBlockTime: DateTime.parse(json['earliest_block_time'] as String),
      latestAppHash: json['latest_app_hash'] as String,
      latestBlockHash: json['latest_block_hash'] as String,
      latestBlockHeight: int.tryParse(json['latest_block_height'] as String) ?? 1,
      latestBlockTime: DateTime.parse(json['latest_block_time'] as String),
    );
  }

  @override
  List<Object?> get props => <Object?>[
        earliestAppHash,
        earliestBlockHash,
        earliestBlockHeight,
        earliestBlockTime,
        latestAppHash,
        latestBlockHash,
        latestBlockHeight,
        latestBlockTime,
      ];
}
