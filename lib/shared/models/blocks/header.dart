import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_blocks/response/header_dto.dart';

class Header extends Equatable {
  final String appHash;
  final String chainId;
  final String consensusHash;
  final String dataHash;
  final String evidenceHash;
  final String height;
  final String proposerAddress;
  final DateTime time;
  final String validatorsHash;

  const Header({
    required this.appHash,
    required this.chainId,
    required this.consensusHash,
    required this.dataHash,
    required this.evidenceHash,
    required this.height,
    required this.proposerAddress,
    required this.time,
    required this.validatorsHash,
  });

  factory Header.fromDto(HeaderDto headerDto) => Header(
        appHash: headerDto.appHash,
        chainId: headerDto.chainId,
        consensusHash: headerDto.consensusHash,
        dataHash: headerDto.dataHash,
        evidenceHash: headerDto.evidenceHash,
        height: headerDto.height,
        proposerAddress: headerDto.proposerAddress,
        time: headerDto.time,
        validatorsHash: headerDto.validatorsHash,
      );

  @override
  List<Object?> get props => <Object?>[
        appHash,
        chainId,
        consensusHash,
        dataHash,
        evidenceHash,
        height,
        proposerAddress,
        time,
        validatorsHash,
      ];
}
