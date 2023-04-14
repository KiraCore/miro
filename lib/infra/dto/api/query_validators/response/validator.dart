import 'package:equatable/equatable.dart';

class Validator extends Equatable {
  final String top;
  final String address;
  final String valkey;
  final String pubkey;
  final String proposer;
  final String moniker;
  final String status;
  final String rank;
  final String streak;
  final String mischance;
  final String mischanceConfidence;
  final String startHeight;
  final String inactiveUntil;
  final String lastPresentBlock;
  final String missedBlocksCounter;
  final String producedBlocksCounter;

  const Validator({
    required this.top,
    required this.address,
    required this.valkey,
    required this.pubkey,
    required this.proposer,
    required this.moniker,
    required this.status,
    required this.rank,
    required this.streak,
    required this.mischance,
    required this.mischanceConfidence,
    required this.startHeight,
    required this.inactiveUntil,
    required this.lastPresentBlock,
    required this.missedBlocksCounter,
    required this.producedBlocksCounter,
  });

  factory Validator.fromJson(Map<String, dynamic> json) {
    return Validator(
      top: json['top'] as String,
      address: json['address'] as String,
      valkey: json['valkey'] as String,
      pubkey: json['pubkey'] as String,
      proposer: json['proposer'] as String,
      moniker: json['moniker'] as String,
      status: json['status'] as String,
      rank: json['rank'] as String,
      streak: json['streak'] as String,
      mischance: json['mischance'] as String,
      mischanceConfidence: json['mischance_confidence'] as String,
      startHeight: json['start_height'] as String,
      inactiveUntil: json['inactive_until'] as String,
      lastPresentBlock: json['last_present_block'] as String,
      missedBlocksCounter: json['missed_blocks_counter'] as String,
      producedBlocksCounter: json['produced_blocks_counter'] as String,
    );
  }

  @override
  List<Object?> get props => <Object>[
        top,
        address,
        valkey,
        pubkey,
        proposer,
        moniker,
        status,
        rank,
        streak,
        mischance,
        mischanceConfidence,
        startHeight,
        inactiveUntil,
        lastPresentBlock,
        missedBlocksCounter,
        producedBlocksCounter,
      ];
}
