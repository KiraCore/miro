import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_blocks/response/block_id_dto.dart';
import 'package:miro/infra/dto/api/query_blocks/response/header_dto.dart';

class BlockMeta extends Equatable {
  final BlockIdDto blockIdDto;
  final String blockSize;
  final HeaderDto headerDto;
  final String numTxs;

  const BlockMeta({
    required this.blockIdDto,
    required this.blockSize,
    required this.headerDto,
    required this.numTxs,
  });

  factory BlockMeta.fromJson(Map<String, dynamic> json) => BlockMeta(
        blockIdDto: BlockIdDto.fromJson(json['block_id'] as Map<String, dynamic>),
        blockSize: json['block_size'] as String,
        headerDto: HeaderDto.fromJson(json['header'] as Map<String, dynamic>),
        numTxs: json['num_txs'] as String,
      );

  @override
  List<Object?> get props => <Object?>[blockIdDto, blockSize, headerDto, numTxs];
}
