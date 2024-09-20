import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:flutter/material.dart';
import 'package:miro/generated/l10n.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class IRMsgCancelVerificationRequestModel extends ATxMsgModel {
  final BigInt verifyRequestId;
  final AWalletAddress walletAddress;

  const IRMsgCancelVerificationRequestModel({
    required this.verifyRequestId,
    required this.walletAddress,
  }) : super(txMsgType: TxMsgType.msgCancelIdentityRecordsVerifyRequest);

  factory IRMsgCancelVerificationRequestModel.fromDto(MsgCancelIdentityRecordsVerifyRequest msgCancelIdentityRecordsVerifyRequest) {
    return IRMsgCancelVerificationRequestModel(
      verifyRequestId: msgCancelIdentityRecordsVerifyRequest.verifyRequestId,
      walletAddress: AWalletAddress.fromAddress(msgCancelIdentityRecordsVerifyRequest.executor.value),
    );
  }

  @override
  MsgCancelIdentityRecordsVerifyRequest toMsgDto() {
    return MsgCancelIdentityRecordsVerifyRequest(
      executor: CosmosAccAddress(walletAddress.address),
      verifyRequestId: verifyRequestId,
    );
  }

  @override
  Widget getIcon(TxDirectionType txDirectionType) {
    return const Icon(Icons.cancel_outlined);
  }

  @override
  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType) {
    return <PrefixedTokenAmountModel>[];
  }

  @override
  String getSubtitle(TxDirectionType txDirectionType) => verifyRequestId.toString();

  @override
  String getTitle(BuildContext context, TxDirectionType txDirectionType) => S.of(context).txMsgCancelIdentityRecordsVerifyRequest;

  @override
  List<Object?> get props => <Object>[verifyRequestId, walletAddress];
}
