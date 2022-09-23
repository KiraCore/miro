import 'package:decimal/decimal.dart';
import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';

class TxPriceModel extends Equatable {
  final TokenAmountModel _tokenAmountModel;
  final TokenAmountModel _feeTokenAmountModel;

  const TxPriceModel({
    required TokenAmountModel tokenAmountModel,
    required TokenAmountModel feeTokenAmountModel,
  })  : _tokenAmountModel = tokenAmountModel,
        _feeTokenAmountModel = feeTokenAmountModel;

  TokenAmountModel get netTokenAmountModel => _tokenAmountModel;

  TokenAmountModel get totalTokenAmountModel {
    TokenAliasModel tokenAliasModel = _tokenAmountModel.tokenAliasModel;
    TokenAliasModel feeTokenAliasModel = _feeTokenAmountModel.tokenAliasModel;
    if (tokenAliasModel != feeTokenAliasModel) {
      return _tokenAmountModel;
    }

    Decimal tokenAmount = _tokenAmountModel.getAmountInLowestDenomination();
    Decimal totalTokenAmount = tokenAmount + _feeTokenAmountModel.getAmountInLowestDenomination();
    return TokenAmountModel(
      lowestDenominationAmount: totalTokenAmount,
      tokenAliasModel: tokenAliasModel,
    );
  }

  @override
  List<Object?> get props => <Object>[_tokenAmountModel, _feeTokenAmountModel];
}
