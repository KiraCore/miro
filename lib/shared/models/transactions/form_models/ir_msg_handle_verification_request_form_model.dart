import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_handle_verification_request_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgHandleVerificationRequestFormModel extends AMsgFormModel {
  final IRInboundVerificationRequestModel irInboundVerificationRequestModel;

  // Form fields
  bool? _approvalStatusBool;
  WalletAddress? _walletAddress;

  IRMsgHandleVerificationRequestFormModel({
    required this.irInboundVerificationRequestModel,
    bool? approvalStatusBool,
    WalletAddress? walletAddress,
  })  : _approvalStatusBool = approvalStatusBool,
        _walletAddress = walletAddress;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_approvalStatusBool] or [_walletAddress] is not filled
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build IRMsgHandleVerificationRequestModel. Form is not valid');
    }
    return IRMsgHandleVerificationRequestModel(
      approvalStatusBool: _approvalStatusBool!,
      verifyRequestId: irInboundVerificationRequestModel.id,
      walletAddress: _walletAddress!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = _approvalStatusBool != null && _walletAddress != null;
    return fieldsFilledBool;
  }

  bool? get approvalStatusBool => _approvalStatusBool;

  set approvalStatusBool(bool? approvalStatusBool) {
    _approvalStatusBool = approvalStatusBool;
    notifyListeners();
  }

  WalletAddress? get walletAddress => _walletAddress;

  set walletAddress(WalletAddress? walletAddress) {
    _walletAddress = walletAddress;
    notifyListeners();
  }
}
