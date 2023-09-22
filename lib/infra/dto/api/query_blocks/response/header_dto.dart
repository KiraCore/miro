import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_blocks/response/block_id_dto.dart';
import 'package:miro/infra/dto/api/query_blocks/response/version.dart';

class HeaderDto extends Equatable {
  final String appHash;
  final String chainId;
  final String consensusHash;
  final String dataHash;
  final String evidenceHash;
  final String height;
  final BlockIdDto lastBlockId;
  final String lastCommitHash;
  final String lastResultsHash;
  final String nextValidatorsHash;
  final String proposerAddress;
  final DateTime time;
  final String validatorsHash;
  final Version version;

  const HeaderDto({
    required this.appHash,
    required this.chainId,
    required this.consensusHash,
    required this.dataHash,
    required this.evidenceHash,
    required this.height,
    required this.lastBlockId,
    required this.lastCommitHash,
    required this.lastResultsHash,
    required this.nextValidatorsHash,
    required this.proposerAddress,
    required this.time,
    required this.validatorsHash,
    required this.version,
  });

  factory HeaderDto.fromJson(Map<String, dynamic> json) => HeaderDto(
        appHash: json['app_hash'] as String,
        chainId: json['chain_id'] as String,
        consensusHash: json['consensus_hash'] as String,
        dataHash: json['data_hash'] as String,
        evidenceHash: json['evidence_hash'] as String,
        height: json['height'] as String,
        lastBlockId: BlockIdDto.fromJson(json['last_block_id'] as Map<String, dynamic>),
        lastCommitHash: json['last_commit_hash'] as String,
        lastResultsHash: json['last_results_hash'] as String,
        nextValidatorsHash: json['next_validators_hash'] as String,
        proposerAddress: json['proposer_address'] as String,
        time: DateTime.parse(json['time'] as String),
        validatorsHash: json['validators_hash'] as String,
        version: Version.fromJson(json['version'] as Map<String, dynamic>),
      );

  @override
  List<Object?> get props => <Object?>[
        appHash,
        chainId,
        consensusHash,
        dataHash,
        evidenceHash,
        height,
        lastBlockId,
        lastCommitHash,
        lastResultsHash,
        nextValidatorsHash,
        proposerAddress,
        time,
        validatorsHash,
        version
      ];
}
