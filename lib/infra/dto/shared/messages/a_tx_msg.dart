import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/infra/dto/shared/messages/msg_undefined.dart';
import 'package:miro/shared/models/transactions/messages/interx_msg_types.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

/// Transaction message objects are shared between endpoints:
/// - QueryTransactions (as single list element in response)
/// - Broadcast (as a transaction message used in request)
/// Represents Msg interface from Kira SDK
/// https://github.com/KiraCore/sekai/blob/master/types/Msg.go
abstract class ATxMsg extends Equatable {
  final String _messageType;
  final String _signatureMessageType;

  const ATxMsg({
    required String messageType,
    required String signatureMessageType,
  })  : _messageType = messageType,
        _signatureMessageType = signatureMessageType;

  static ATxMsg buildFromJson(Map<String, dynamic> json) {
    TxMsgType txMsgType = InterxMsgTypes.getType(json['type'] as String);

    switch (txMsgType) {
      case TxMsgType.msgSend:
        return MsgSend.fromJson(json);
      case TxMsgType.msgRegisterIdentityRecords:
        return MsgRegisterIdentityRecords.fromJson(json);
      case TxMsgType.msgRequestIdentityRecordsVerify:
        return MsgRequestIdentityRecordsVerify.fromJson(json);
      case TxMsgType.msgHandleIdentityRecordsVerifyRequest:
        return MsgHandleIdentityRecordsVerifyRequest.fromJson(json);
      case TxMsgType.msgCancelIdentityRecordsVerifyRequest:
        return MsgCancelIdentityRecordsVerifyRequest.fromJson(json);
      case TxMsgType.msgDeleteIdentityRecords:
        return MsgDeleteIdentityRecords.fromJson(json);
      default:
        return const MsgUndefined();
    }
  }

  Map<String, dynamic> toJson();

  Map<String, dynamic> toJsonWithType() {
    return <String, dynamic>{
      '@type': _messageType,
      ...toJson(),
    };
  }

  Map<String, dynamic> toSignatureJson() {
    return <String, dynamic>{
      'type': _signatureMessageType,
      'value': toJson(),
    };
  }
}
