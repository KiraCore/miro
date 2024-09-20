import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_delegate_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class StakingMsgDelegateFormModel extends AMsgFormModel {
  // Form fields
  String? _valkey;
  AWalletAddress? _delegatorWalletAddress;
  List<TokenAmountModel>? _tokenAmountModels;

  // Values required to be saved to allow editing transaction
  BalanceModel? balanceModel;
  TokenAliasModel? tokenAliasModel;
  TokenDenominationModel? tokenDenominationModel;

  StakingMsgDelegateFormModel({
    String? valkey,
    AWalletAddress? delegatorWalletAddress,
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
      throw Exception('Cannot build StakingMsgDelegateModel. Form is not valid');
    }
    return StakingMsgDelegateModel(
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

  AWalletAddress? get delegatorWalletAddress => _delegatorWalletAddress;

  set delegatorWalletAddress(AWalletAddress? delegatorWalletAddress) {
    _delegatorWalletAddress = delegatorWalletAddress;
    notifyListeners();
  }

  String? get valkey => _valkey;

  set valoperWalletAddress(String? valkey) {
    _valkey = valkey;
    notifyListeners();
  }

  List<TokenAmountModel>? get tokenAmountModels => _tokenAmountModels;

  set tokenAmountModels(List<TokenAmountModel>? tokenAmountModels) {
    _tokenAmountModels = tokenAmountModels;
    notifyListeners();
  }
}
