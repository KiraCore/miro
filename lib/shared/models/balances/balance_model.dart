import 'package:decimal/decimal.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/a_list_item.dart';
import 'package:miro/infra/dto/api_kira/query_balance/response/balance.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class BalanceModel extends AListItem {
  final TokenAmountModel tokenAmountModel;
  late bool _favourite;

  BalanceModel({
    required this.tokenAmountModel,
    bool favourite = false,
  }) : _favourite = favourite;

  factory BalanceModel.fromDto(Balance balance) {
    return BalanceModel(
        tokenAmountModel: TokenAmountModel(
      defaultDenominationAmount: Decimal.parse(balance.amount),
      tokenAliasModel: TokenAliasModel.local(balance.denom),
    ));
  }

  BalanceModel fillTokenAlias(List<TokenAliasModel> tokenAliasModels) {
    TokenAmountModel filledTokenAmountModel = tokenAmountModel.copyWith(
        tokenAliasModel: tokenAliasModels.firstWhere(
            (TokenAliasModel tokenAliasModel) =>
                tokenAliasModel.defaultTokenDenominationModel.name == tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name,
            orElse: () => tokenAmountModel.tokenAliasModel));
    return BalanceModel(tokenAmountModel: filledTokenAmountModel);
  }

  String get defaultDenomName {
    return tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name;
  }

  @override
  String get cacheId => tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel.name;

  @override
  bool get isFavourite => _favourite;

  @override
  set favourite(bool value) => _favourite = value;

  @override
  String toString() {
    return 'BalanceModel{tokenAmountModel: $tokenAmountModel, _favourite: $_favourite}';
  }
}
