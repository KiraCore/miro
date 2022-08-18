import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MsgHandleIdentityRecordsVerifyRequestModel extends Equatable implements ITxMsgModel {
  final bool approved;
  final BigInt verifyRequestId;
  final WalletAddress walletAddress;

  const MsgHandleIdentityRecordsVerifyRequestModel({
    required this.approved,
    required this.verifyRequestId,
    required this.walletAddress,
  });

  factory MsgHandleIdentityRecordsVerifyRequestModel.fromDto(MsgHandleIdentityRecordsVerifyRequest msgHandleIdentityRecordsVerifyRequest) {
    return MsgHandleIdentityRecordsVerifyRequestModel(
      approved: msgHandleIdentityRecordsVerifyRequest.yes,
      verifyRequestId: msgHandleIdentityRecordsVerifyRequest.verifyRequestId,
      walletAddress: WalletAddress.fromBech32(msgHandleIdentityRecordsVerifyRequest.verifier),
    );
  }

  @override
  ITxMsg toMsgDto() {
    return MsgHandleIdentityRecordsVerifyRequest(
      verifyRequestId: verifyRequestId,
      verifier: walletAddress.bech32Address,
      yes: approved,
    );
  }

  @override
  List<Object?> get props => <Object>[approved, verifyRequestId, walletAddress];
}
