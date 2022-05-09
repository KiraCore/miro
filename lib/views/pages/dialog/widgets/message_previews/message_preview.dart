import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/vote/msg_vote.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_fee.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/signed_transaction.dart';
import 'package:miro/views/pages/dialog/widgets/message_previews/msg_send_preview.dart';
import 'package:miro/views/pages/dialog/widgets/message_previews/msg_vote_preview.dart';
import 'package:miro/views/pages/dialog/widgets/message_previews/undefined_transaction_preview.dart';

class MessagePreview extends StatelessWidget {
  /// [SignedTransaction] or [UnsignedTransaction]
  final dynamic transaction;
  final String memo;
  final TxFee fee;
  final TxMsg message;

  const MessagePreview({
    required this.transaction,
    required this.memo,
    required this.fee,
    required this.message,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (message.runtimeType) {
      // TODO(dominik): implement all message types
      // case MsgCancelIdentityRecordsVerifyRequest:
      //   return _MsgCancelIdentityRecordsVerifyRequestPreview(message: message, transaction: transaction);
      // case MsgDeleteIdentityRecords:
      //   return _MsgDeleteIdentityRecordsPreview(message: message, transaction: transaction);
      // case MsgHandleIdentityRecordsVerifyRequest:
      //   return _MsgHandleIdentityRecordsVerifyRequestPreview(message: message, transaction: transaction);
      // case MsgRegisterIdentityRecords:
      //   return _MsgRegisterIdentityRecordsPreview(message: message, transaction: transaction);
      // case MsgRequestIdentityRecordsVerify:
      //   return _MsgRequestIdentityRecordsVerifyPreview(message: message, transaction: transaction);
      case MsgVote:
        return MsgVotePreview(
          message: message as MsgVote,
          fee: fee,
          memo: memo,
        );
      case MsgSend:
        return MsgSendPreview(
          message: message as MsgSend,
          fee: fee,
          memo: memo,
        );
      default:
        return UndefinedTransactionPreview(
          transaction: transaction,
          message: message,
          fee: fee,
        );
    }
  }
}
