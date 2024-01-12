import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_undelegate_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingMsgUndelegateFormModel extends AMsgFormModel {
  // Form fields
  WalletAddress? _delegatorWalletAddress;
  WalletAddress? _valoperWalletAddress;
  List<TokenAmountModel>? _tokenAmountModels;

  // Values required to be saved to allow editing transaction
  BalanceModel? balanceModel;
  TokenAliasModel? tokenAliasModel;
  TokenDenominationModel? tokenDenominationModel;

  StakingMsgUndelegateFormModel({
    WalletAddress? delegatorWalletAddress,
    WalletAddress? valoperWalletAddress,
    List<TokenAmountModel>? tokenAmountModels,
    this.balanceModel,
    this.tokenAliasModel,
    this.tokenDenominationModel,
  })  : _delegatorWalletAddress = delegatorWalletAddress,
        _valoperWalletAddress = valoperWalletAddress,
        _tokenAmountModels = tokenAmountModels;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_delegatorWalletAddress], [_valoperWalletAddress] or [_tokenAmountModels]
  /// is not filled (equal null) or [_tokenAmountModels] is empty List.
  ///
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build StakingMsgUndelegateModel. Form is not valid');
    }
    return StakingMsgUndelegateModel(
      delegatorWalletAddress: _delegatorWalletAddress!,
      valoperWalletAddress: _valoperWalletAddress!,
      tokenAmountModels: _tokenAmountModels!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool amountZeroBool = tokenAmountModels?.length == 1 && tokenAmountModels?.first.getAmountInDefaultDenomination() == Decimal.zero;
    bool fieldsFilledBool = _delegatorWalletAddress != null && _valoperWalletAddress != null && tokenAmountModels != null && amountZeroBool == false;
    return fieldsFilledBool;
  }

  WalletAddress? get delegatorWalletAddress => _delegatorWalletAddress;

  set delegatorWalletAddress(WalletAddress? delegatorWalletAddress) {
    _delegatorWalletAddress = delegatorWalletAddress;
    notifyListeners();
  }

  WalletAddress? get valoperWalletAddress => _valoperWalletAddress;

  set valoperWalletAddress(WalletAddress? validatorWalletAddress) {
    _valoperWalletAddress = validatorWalletAddress;
    notifyListeners();
  }

  List<TokenAmountModel>? get tokenAmountModels => _tokenAmountModels;

  set tokenAmountModels(List<TokenAmountModel>? tokenAmountModels) {
    _tokenAmountModels = tokenAmountModels;
    notifyListeners();
  }
}
