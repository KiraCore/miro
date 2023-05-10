import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class BalanceModel extends AListItem {
  final TokenAmountModel tokenAmountModel;
  late bool _favourite;

  BalanceModel({
    required this.tokenAmountModel,
    bool favourite = false,
  }) : _favourite = favourite;

  @override
  String get cacheId => tokenAmountModel.tokenAliasModel.lowestTokenDenominationModel.name;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  @override
  String toString() {
    return 'BalanceModel{tokenAmountModel: $tokenAmountModel, _favourite: $_favourite}';
  }
}
