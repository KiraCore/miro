import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api/query_transactions/response/transaction.dart';

class TxListItemModel extends AListItem {
  final String hash;
  bool _favourite = false;

  TxListItemModel({
    required this.hash,
  });

  factory TxListItemModel.fromDto(Transaction transaction) {
    return TxListItemModel(
      hash: transaction.hash,
    );
  }

  @override
  String get cacheId => hash;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  @override
  String toString() {
    return 'TxListItemModel{hash: $hash}';
  }
}
