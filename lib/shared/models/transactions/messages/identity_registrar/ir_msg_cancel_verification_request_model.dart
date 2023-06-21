import 'package:miro/infra/dto/shared/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgCancelVerificationRequestModel extends ATxMsgModel {
  final BigInt verifyRequestId;
  final WalletAddress walletAddress;

  const IRMsgCancelVerificationRequestModel({
    required this.verifyRequestId,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgCancelIdentityRecordsVerifyRequest);

  factory IRMsgCancelVerificationRequestModel.fromDto(MsgCancelIdentityRecordsVerifyRequest msgCancelIdentityRecordsVerifyRequest) {
    return IRMsgCancelVerificationRequestModel(
      verifyRequestId: msgCancelIdentityRecordsVerifyRequest.verifyRequestId,
      walletAddress: WalletAddress.fromBech32(msgCancelIdentityRecordsVerifyRequest.executor),
    );
  }

  @override
  MsgCancelIdentityRecordsVerifyRequest toMsgDto() {
    return MsgCancelIdentityRecordsVerifyRequest(
      executor: walletAddress.bech32Address,
      verifyRequestId: verifyRequestId,
    );
  }

  @override
  List<Object?> get props => <Object>[verifyRequestId, walletAddress];
}
