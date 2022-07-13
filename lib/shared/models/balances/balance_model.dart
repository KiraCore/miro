import 'package:miro/blocs/abstract_blocs/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';

class BalanceModel extends AListItem {
  final TokenAmount tokenAmount;
  late bool _favourite;

  BalanceModel({
    required this.tokenAmount,
    bool favourite = false,
  }) : _favourite = favourite;

  @override
  String get cacheId => tokenAmount.tokenAliasModel.lowestTokenDenomination.name;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  @override
  String toString() {
    return 'BalanceModel{tokenAmount: $tokenAmount, _favourite: $_favourite}';
  }
}
