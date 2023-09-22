import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api/query_blocks/response/block_meta.dart';

@immutable
class QueryBlocksResp extends Equatable {
  final List<BlockMeta> blockMetas;
  final String lastHeight;

  const QueryBlocksResp({
    required this.blockMetas,
    required this.lastHeight,
  });

  factory QueryBlocksResp.fromJson(Map<String, dynamic> json) => QueryBlocksResp(
        blockMetas: (json['block_metas'] as List<dynamic>).map((dynamic e) => BlockMeta.fromJson(e as Map<String, dynamic>)).toList(),
        lastHeight: json['last_height'] as String,
      );

  @override
  List<Object?> get props => <Object?>[blockMetas, lastHeight];
}
