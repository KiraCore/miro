import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/blocks/block_id.dart';
import 'package:miro/shared/models/blocks/header.dart';

class BlockModel extends AListItem {
  final BlockId blockId;
  final int blockSize;
  final Header header;
  final int numTxs;
  bool _favourite = false;

  BlockModel({
    required this.blockId,
    required this.blockSize,
    required this.header,
    required this.numTxs,
  });

  factory BlockModel.fromJson(Map<String, dynamic> json) {
    Map<String, dynamic> blockData = json['block'] as Map<String, dynamic>;
    Map<String, dynamic> headerData = blockData['header'] as Map<String, dynamic>;
    Map<String, dynamic> blockIdData = json['block_id'] as Map<String, dynamic>;

    // Calculate numTxs from txs array in block.data
    int numTxs = 0;
    if (blockData['data'] != null) {
      Map<String, dynamic> dataMap = blockData['data'] as Map<String, dynamic>;
      if (dataMap['txs'] != null) {
        numTxs = (dataMap['txs'] as List<dynamic>).length;
      }
    }

    return BlockModel(
      blockId: BlockId.fromJson(blockIdData),
      // TODO: #32 blockSize not available in new API structure
      blockSize: 0,
      header: Header.fromJson(headerData),
      numTxs: numTxs,
    );
  }

  @override
  String get cacheId => header.height.toString();

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;
}
