import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api/query_blocks/response/block_id_dto.dart';

class BlockId extends Equatable {
  final String hash;

  const BlockId({required this.hash});

  factory BlockId.fromDto(BlockIdDto blockIdDto) => BlockId(
        hash: blockIdDto.hash,
      );

  @override
  List<Object?> get props => <Object?>[hash];
}
