import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/staking/staking_msg_claim_undelegation_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class StakingMsgClaimUndelegationFormModel extends AMsgFormModel {
// Form fields
  WalletAddress? _senderWalletAddress;
  String? _undelegationId;

  StakingMsgClaimUndelegationFormModel({
    WalletAddress? senderWalletAddress,
    String? undelegationId,
  })  : _senderWalletAddress = senderWalletAddress,
        _undelegationId = undelegationId;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_senderWalletAddress] or [_undelegationId] is not filled (equal null).
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build StakingMsgClaimUndelegationModel. Form is not valid');
    }
    return StakingMsgClaimUndelegationModel(
      senderWalletAddress: _senderWalletAddress!,
      undelegationId: _undelegationId!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = (_senderWalletAddress != null) && (_undelegationId != null);
    return fieldsFilledBool;
  }

  WalletAddress? get senderWalletAddress => _senderWalletAddress;

  set senderWalletAddress(WalletAddress? senderWalletAddress) {
    _senderWalletAddress = senderWalletAddress;
    notifyListeners();
  }

  String? get undelegationId => _undelegationId;

  set undelegationId(String? undelegationId) {
    _undelegationId = undelegationId;
    notifyListeners();
  }
}
