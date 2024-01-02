import 'package:miro/blocs/widgets/kira/kira_list/filters/models/filter_option.dart';
import 'package:miro/shared/models/blocks/block_model.dart';

class BlocksFilterOptions {
  static FilterComparator<BlockModel> search(String searchText) {
    return (BlockModel blockModel) {
      bool hashMatchBool = blockModel.blockId.hash.toLowerCase().contains(searchText.toLowerCase());
      bool heightMatchBool = blockModel.header.height.toLowerCase().contains(searchText.toLowerCase());
      return hashMatchBool || heightMatchBool;
    };
  }
}
