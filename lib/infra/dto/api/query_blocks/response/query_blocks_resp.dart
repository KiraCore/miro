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
    List<BlockModel> blocks = (json['blocks'] as List<dynamic>? ?? <dynamic>[])
        .map((dynamic e) => BlockModel.fromJson(e as Map<String, dynamic>))
        .toList();

    int lastHeight = 0;

    // Try to get last_height from root
    if (json['last_height'] != null) {
      if (json['last_height'] is String) {
        lastHeight = int.tryParse(json['last_height'] as String) ?? 0;
      } else if (json['last_height'] is int) {
        lastHeight = json['last_height'] as int;
      }
    }

    // If not found, try pagination.total
    if (lastHeight == 0 && json['pagination'] != null) {
      final dynamic total =
          (json['pagination'] as Map<String, dynamic>)['total'];
      if (total is int) {
        lastHeight = total;
      } else if (total is String) {
        lastHeight = int.tryParse(total) ?? 0;
      }
    }

    // If still not found and we have blocks, use the first block's height
    if (lastHeight == 0 && blocks.isNotEmpty) {
      lastHeight = int.tryParse(blocks.first.header.height) ?? 0;
    }

    return QueryBlocksResp(
      blocks: blocks,
      lastHeight: lastHeight,
    );
  }

  @override
  List<Object?> get props => <Object?>[blocks, lastHeight];
}
