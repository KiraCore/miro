import 'package:equatable/equatable.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class TokenFormState extends Equatable {
  final TokenAmountModel feeTokenAmountModel;
  final bool errorBool;
  final bool loadingBool;
  final BalanceModel? balanceModel;
  final TokenAliasModel? tokenAliasModel;
  final TokenAmountModel? tokenAmountModel;
  final TokenDenominationModel? tokenDenominationModel;
  final WalletAddress? walletAddress;

  const TokenFormState._({
    required this.feeTokenAmountModel,
    this.errorBool = false,
    this.loadingBool = false,
    this.balanceModel,
    this.tokenAliasModel,
    this.tokenAmountModel,
    this.tokenDenominationModel,
    this.walletAddress,
  });

  factory TokenFormState.fromBalance({
    required BalanceModel balanceModel,
    required TokenAmountModel feeTokenAmountModel,
    required WalletAddress? walletAddress,
    bool loadingBool = false,
    TokenAmountModel? tokenAmountModel,
    TokenDenominationModel? tokenDenominationModel,
  }) {
    TokenAliasModel tokenAliasModel = balanceModel.tokenAmountModel.tokenAliasModel;

    return TokenFormState._(
      balanceModel: balanceModel,
      feeTokenAmountModel: feeTokenAmountModel,
      walletAddress: walletAddress,
      loadingBool: loadingBool,
      tokenAmountModel: tokenAmountModel ?? TokenAmountModel.zero(tokenAliasModel: tokenAliasModel),
      tokenDenominationModel: tokenDenominationModel ?? tokenAliasModel.defaultTokenDenominationModel,
    );
  }

  factory TokenFormState.fromTokenAlias({
    required TokenAliasModel tokenAliasModel,
    required TokenAmountModel feeTokenAmountModel,
    required WalletAddress? walletAddress,
    bool loadingBool = false,
    TokenDenominationModel? tokenDenominationModel,
  }) {
    return TokenFormState._(
      tokenAliasModel: tokenAliasModel,
      feeTokenAmountModel: feeTokenAmountModel,
      walletAddress: walletAddress,
      loadingBool: loadingBool,
      tokenDenominationModel: tokenDenominationModel ?? tokenAliasModel.defaultTokenDenominationModel,
    );
  }

  TokenFormState copyWith({
    TokenAmountModel? feeTokenAmountModel,
    bool? errorBool,
    bool? loadingBool,
    BalanceModel? balanceModel,
    TokenDenominationModel? tokenDenominationModel,
    TokenAliasModel? tokenAliasModel,
    TokenAmountModel? tokenAmountModel,
    WalletAddress? walletAddress,
  }) {
    return TokenFormState._(
      feeTokenAmountModel: feeTokenAmountModel ?? this.feeTokenAmountModel,
      errorBool: errorBool ?? this.errorBool,
      loadingBool: loadingBool ?? this.loadingBool,
      tokenDenominationModel: tokenDenominationModel ?? this.tokenDenominationModel,
      balanceModel: balanceModel ?? this.balanceModel,
      tokenAliasModel: tokenAliasModel ?? this.tokenAliasModel,
      tokenAmountModel: tokenAmountModel ?? this.tokenAmountModel,
      walletAddress: walletAddress ?? this.walletAddress,
    );
  }

  TokenAmountModel? get availableTokenAmountModel {
    if (balanceModel == null) {
      return null;
    } else {
      return balanceModel!.tokenAmountModel - feeTokenAmountModel;
    }
  }

  @override
  List<Object?> get props => <Object?>[tokenDenominationModel, balanceModel, tokenAmountModel, walletAddress];
}
