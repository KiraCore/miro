import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgHandleVerificationRequestModel extends ATxMsgModel {
  final bool approvalStatusBool;
  final String verifyRequestId;
  final WalletAddress walletAddress;

  const IRMsgHandleVerificationRequestModel({
    required this.approvalStatusBool,
    required this.verifyRequestId,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgHandleIdentityRecordsVerifyRequest);

  factory IRMsgHandleVerificationRequestModel.fromDto(MsgHandleIdentityRecordsVerifyRequest msgHandleIdentityRecordsVerifyRequest) {
    return IRMsgHandleVerificationRequestModel(
      approvalStatusBool: msgHandleIdentityRecordsVerifyRequest.yes,
      verifyRequestId: msgHandleIdentityRecordsVerifyRequest.verifyRequestId.toString(),
      walletAddress: WalletAddress.fromBech32(msgHandleIdentityRecordsVerifyRequest.verifier),
    );
  }

  @override
  MsgHandleIdentityRecordsVerifyRequest toMsgDto() {
    return MsgHandleIdentityRecordsVerifyRequest(
      verifyRequestId: int.parse(verifyRequestId),
      verifier: walletAddress.bech32Address,
      yes: approvalStatusBool,
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.verified_outlined);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) => verifyRequestId.toString();

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgHandleIdentityRecordsVerifyRequest;

  @override
  List<Object?> get props => <Object>[approvalStatusBool, verifyRequestId, walletAddress];
}
