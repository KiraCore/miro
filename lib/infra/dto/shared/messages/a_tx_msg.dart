import 'package:cryptography_utils/cryptography_utils.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/infra/dto/shared/messages/msg_undefined.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_claim_rewards.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_claim_undelegation.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_delegate.dart';
import 'package:miro/infra/dto/shared/messages/staking/msg_undelegate.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

/// Transaction message objects are shared between endpoints:
/// - QueryTransactions (as single list element in response)
/// - Broadcast (as a transaction message used in request)
/// Represents Msg interface from Kira SDK
/// https://github.com/KiraCore/sekai/blob/master/types/Msg.go
abstract class ATxMsg extends ProtobufAny {
  const ATxMsg({
    required super.typeUrl,
  });

  static ATxMsg buildFromJson(Map<String, dynamic> json) {
    TxMsgType txMsgType = InterxMsgTypes.getType(json['type'] as String);

    switch (txMsgType) {
      case TxMsgType.msgCancelIdentityRecordsVerifyRequest:
        return MsgCancelIdentityRecordsVerifyRequest.fromData(json);
      case TxMsgType.msgClaimRewards:
        return MsgClaimRewards.fromData(json);
      case TxMsgType.msgClaimUndelegation:
        return MsgClaimUndelegation.fromData(json);
      case TxMsgType.msgDelegate:
        return MsgDelegate.fromData(json);
      case TxMsgType.msgDeleteIdentityRecords:
        return MsgDeleteIdentityRecords.fromData(json);
      case TxMsgType.msgHandleIdentityRecordsVerifyRequest:
        return MsgHandleIdentityRecordsVerifyRequest.fromData(json);
      case TxMsgType.msgRegisterIdentityRecords:
        return MsgRegisterIdentityRecords.fromData(json);
      case TxMsgType.msgRequestIdentityRecordsVerify:
        return MsgRequestIdentityRecordsVerify.fromData(json);
      case TxMsgType.msgSend:
        return MsgSend.fromData(json);
      case TxMsgType.msgUndelegate:
        return MsgUndelegate.fromData(json);
      default:
        return const MsgUndefined();
    }
  }
}
