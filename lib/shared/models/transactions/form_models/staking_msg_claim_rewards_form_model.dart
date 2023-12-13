import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_rewards_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingMsgClaimRewardsFormModel extends AMsgFormModel {
  // Form fields
  WalletAddress? _senderWalletAddress;

  StakingMsgClaimRewardsFormModel({
    WalletAddress? senderWalletAddress,
  }) : _senderWalletAddress = senderWalletAddress;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_senderWalletAddress] is not filled (equal null).
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build StakingMsgClaimRewardsModel. Form is not valid');
    }
    return StakingMsgClaimRewardsModel(
      senderWalletAddress: _senderWalletAddress!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = _senderWalletAddress != null;
    return fieldsFilledBool;
  }

  WalletAddress? get senderWalletAddress => _senderWalletAddress;

  set senderWalletAddress(WalletAddress? senderWalletAddress) {
    _senderWalletAddress = senderWalletAddress;
    notifyListeners();
  }
}
