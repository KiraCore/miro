import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';

class TokenFormState extends Equatable {
  final TokenAmountModel feeTokenAmountModel;
  final BalanceModel? balanceModel;
  final TokenAmountModel? tokenAmountModel;
  final TokenDenominationModel? tokenDenominationModel;

  const TokenFormState({
    required this.feeTokenAmountModel,
    this.balanceModel,
    this.tokenAmountModel,
    this.tokenDenominationModel,
  });

  factory TokenFormState.assignDefaults({
    required TokenAmountModel feeTokenAmountModel,
    BalanceModel? defaultBalanceModel,
    TokenAmountModel? defaultTokenAmountModel,
    TokenDenominationModel? defaultTokenDenominationModel,
  }) {
    TokenAmountModel? tokenAmountModel;
    TokenDenominationModel? tokenDenominationModel;

    if (defaultTokenAmountModel != null) {
      tokenAmountModel = defaultTokenAmountModel;
    } else if (defaultBalanceModel != null) {
      tokenAmountModel = TokenAmountModel.zero(tokenAliasModel: defaultBalanceModel.tokenAmountModel.tokenAliasModel);
    }

    if (defaultTokenDenominationModel != null) {
      tokenDenominationModel = defaultTokenDenominationModel;
    } else if (defaultBalanceModel != null) {
      tokenDenominationModel = defaultBalanceModel.tokenAmountModel.tokenAliasModel.defaultTokenDenominationModel;
    }

    return TokenFormState(
      feeTokenAmountModel: feeTokenAmountModel,
      tokenDenominationModel: tokenDenominationModel,
      balanceModel: defaultBalanceModel,
      tokenAmountModel: tokenAmountModel,
    );
  }

  TokenFormState copyWith({
    TokenAmountModel? feeTokenAmountModel,
    BalanceModel? balanceModel,
    TokenDenominationModel? tokenDenominationModel,
    TokenAmountModel? tokenAmountModel,
  }) {
    return TokenFormState(
      feeTokenAmountModel: feeTokenAmountModel ?? this.feeTokenAmountModel,
      tokenDenominationModel: tokenDenominationModel ?? this.tokenDenominationModel,
      balanceModel: balanceModel ?? this.balanceModel,
      tokenAmountModel: tokenAmountModel ?? this.tokenAmountModel,
    );
  }

  TokenAmountModel? get availableTokenAmountModel {
    if( balanceModel == null ) {
      return null;
    } else {
      return balanceModel!.tokenAmountModel - feeTokenAmountModel;
    }
  }

  @override
  List<Object?> get props => <Object?>[tokenDenominationModel, balanceModel, tokenAmountModel];
}
