import 'package:miro/blocs/widgets/kira/kira_list/sort/models/sort_option.dart';
import 'package:miro/shared/models/blocks/block_model.dart';

class BlocksSortOptions {
  static SortOption<BlockModel> get sortByHeight {
    return SortOption<BlockModel>.asc(
      id: 'height',
      comparator: (BlockModel a, BlockModel b) => a.header.height.compareTo(b.header.height),
    );
  }
}
