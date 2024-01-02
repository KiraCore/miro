import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/blocks/block_id.dart';
import 'package:miro/shared/models/blocks/header.dart';

class BlockModel extends AListItem {
  final BlockId blockId;
  final String blockSize;
  final Header header;
  final String numTxs;
  bool _favourite = false;

  BlockModel({
    required this.blockId,
    required this.blockSize,
    required this.header,
    required this.numTxs,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) => BlockModel(
        blockId: BlockId.fromJson(json['block_id'] as Map<String, dynamic>),
        blockSize: json['block_size'] as String,
        header: Header.fromJson(json['header'] as Map<String, dynamic>),
        numTxs: json['num_txs'] as String,
      );

  @override
  String get cacheId => header.height;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;
}
