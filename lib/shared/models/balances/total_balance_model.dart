import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TotalBalanceModel extends Equatable {
  final BalanceModel _balanceModel;
  final TokenAmountModel _feeTokenAmountModel;

  const TotalBalanceModel({
    required BalanceModel balanceModel,
    required TokenAmountModel feeTokenAmountModel,
  })  : _balanceModel = balanceModel,
        _feeTokenAmountModel = feeTokenAmountModel;

  BalanceModel get balanceModel => _balanceModel;

  TokenAliasModel get tokenAliasModel => _balanceModel.tokenAmountModel.tokenAliasModel;

  TokenAmountModel get availableTokenAmountModel {
    TokenAliasModel balanceTokenAliasModel = _balanceModel.tokenAmountModel.tokenAliasModel;
    TokenAliasModel feeTokenAliasModel = _feeTokenAmountModel.tokenAliasModel;
    if (balanceTokenAliasModel != feeTokenAliasModel) {
      return totalTokenAmountModel;
    }

    Decimal totalAmount = totalTokenAmountModel.getAmountInLowestDenomination();
    Decimal availableTokenAmount = totalAmount - _feeTokenAmountModel.getAmountInLowestDenomination();
    return TokenAmountModel(
      lowestDenominationAmount: availableTokenAmount,
      tokenAliasModel: totalTokenAmountModel.tokenAliasModel,
    );
  }

  TokenAmountModel get totalTokenAmountModel => _balanceModel.tokenAmountModel;

  @override
  List<Object?> get props => <Object>[_balanceModel, _feeTokenAmountModel];
}
