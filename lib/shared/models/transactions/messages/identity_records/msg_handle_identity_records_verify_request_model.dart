import 'package:miro/infra/dto/shared/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgHandleIdentityRecordsVerifyRequestModel extends ATxMsgModel {
  final bool approvedBool;
  final BigInt verifyRequestId;
  final WalletAddress walletAddress;

  const MsgHandleIdentityRecordsVerifyRequestModel({
    required this.approvedBool,
    required this.verifyRequestId,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgHandleIdentityRecordsVerifyRequest);

  factory MsgHandleIdentityRecordsVerifyRequestModel.fromDto(MsgHandleIdentityRecordsVerifyRequest msgHandleIdentityRecordsVerifyRequest) {
    return MsgHandleIdentityRecordsVerifyRequestModel(
      approvedBool: msgHandleIdentityRecordsVerifyRequest.yes,
      verifyRequestId: msgHandleIdentityRecordsVerifyRequest.verifyRequestId,
      walletAddress: WalletAddress.fromBech32(msgHandleIdentityRecordsVerifyRequest.verifier),
    );
  }

  @override
  MsgHandleIdentityRecordsVerifyRequest toMsgDto() {
    return MsgHandleIdentityRecordsVerifyRequest(
      verifyRequestId: verifyRequestId,
      verifier: walletAddress.bech32Address,
      yes: approvedBool,
    );
  }

  @override
  List<Object?> get props => <Object>[approvedBool, verifyRequestId, walletAddress];
}
