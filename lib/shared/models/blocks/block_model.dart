import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api/query_blocks/response/block_meta.dart';
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

  factory BlockModel.fromDto(BlockMeta blockMeta) => BlockModel(
        blockId: BlockId.fromDto(blockMeta.blockIdDto),
        blockSize: blockMeta.blockSize,
        header: Header.fromDto(blockMeta.headerDto),
        numTxs: blockMeta.numTxs,
      );

  @override
  String get cacheId => header.height;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;
}
