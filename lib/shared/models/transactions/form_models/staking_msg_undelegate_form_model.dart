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
  String? _valkey;
  WalletAddress? _delegatorWalletAddress;
  List<TokenAmountModel>? _tokenAmountModels;

  // Values required to be saved to allow editing transaction
  BalanceModel? balanceModel;
  TokenAliasModel? tokenAliasModel;
  TokenDenominationModel? tokenDenominationModel;

  StakingMsgUndelegateFormModel({
    String? valkey,
    WalletAddress? delegatorWalletAddress,
    List<TokenAmountModel>? tokenAmountModels,
    this.balanceModel,
    this.tokenAliasModel,
    this.tokenDenominationModel,
  })  : _valkey = valkey,
        _delegatorWalletAddress = delegatorWalletAddress,
        _tokenAmountModels = tokenAmountModels;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_valkey], [_delegatorWalletAddress] or [_tokenAmountModels]
  /// is not filled (equal null) or [_tokenAmountModels] is empty List.
  ///
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build StakingMsgUndelegateModel. Form is not valid');
    }
    return StakingMsgUndelegateModel(
      valkey: _valkey!,
      delegatorWalletAddress: _delegatorWalletAddress!,
      tokenAmountModels: _tokenAmountModels!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool amountZeroBool = tokenAmountModels?.length == 1 && tokenAmountModels?.first.getAmountInDefaultDenomination() == Decimal.zero;
    bool fieldsFilledBool = _delegatorWalletAddress != null && _valkey != null && tokenAmountModels != null && amountZeroBool == false;
    return fieldsFilledBool;
  }

  WalletAddress? get delegatorWalletAddress => _delegatorWalletAddress;

  set delegatorWalletAddress(WalletAddress? delegatorWalletAddress) {
    _delegatorWalletAddress = delegatorWalletAddress;
    notifyListeners();
  }

  String? get valkey => _valkey;

  set valoperWalletAddress(WalletAddress? validatorWalletAddress) {
    _valkey = valkey;
    notifyListeners();
  }

  List<TokenAmountModel>? get tokenAmountModels => _tokenAmountModels;

  set tokenAmountModels(List<TokenAmountModel>? tokenAmountModels) {
    _tokenAmountModels = tokenAmountModels;
    notifyListeners();
  }
}
