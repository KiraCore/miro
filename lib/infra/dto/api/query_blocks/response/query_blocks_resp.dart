import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/blocks/block_model.dart';

class QueryBlocksResp extends Equatable {
  final List<BlockModel> blocks;
  final int lastHeight;

  const QueryBlocksResp({
    required this.blocks,
    required this.lastHeight,
  });

  factory QueryBlocksResp.fromJson(Map<String, dynamic> json) {
    return QueryBlocksResp(
      blocks: (json['block_metas'] as List<dynamic>? ?? <dynamic>[])
          .map((dynamic e) => BlockModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      lastHeight: int.tryParse(json['last_height'] as String) ?? 0,
    );
  }

  @override
  List<Object?> get props => <Object?>[blocks, lastHeight];
}
