import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_cancel_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_delete_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_handle_identity_records_verify_request.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/msg_request_identity_records_verify.dart';
import 'package:miro/infra/dto/shared/messages/identity_records/register/msg_register_identity_records.dart';
import 'package:miro/infra/dto/shared/messages/msg_send.dart';
import 'package:miro/shared/models/tokens/prefixed_token_amount_model.dart';
import 'package:miro/shared/models/transactions/list/tx_direction_type.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_cancel_verification_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_delete_records_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_handle_verification_request_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_request_verification_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_msg_register_records_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_undefined_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

abstract class ATxMsgModel extends Equatable {
  final TxMsgType txMsgType;

  const ATxMsgModel({
    required this.txMsgType,
  });

  static ATxMsgModel buildFromDto(ATxMsg msgDto) {
    switch (msgDto.runtimeType) {
      case MsgSend:
        return MsgSendModel.fromMsgDto(msgDto as MsgSend);
      case MsgRegisterIdentityRecords:
        return IRMsgRegisterRecordsModel.fromDto(msgDto as MsgRegisterIdentityRecords);
      case MsgCancelIdentityRecordsVerifyRequest:
        return IRMsgCancelVerificationRequestModel.fromDto(msgDto as MsgCancelIdentityRecordsVerifyRequest);
      case MsgDeleteIdentityRecords:
        return IRMsgDeleteRecordsModel.fromDto(msgDto as MsgDeleteIdentityRecords);
      case MsgHandleIdentityRecordsVerifyRequest:
        return IRMsgHandleVerificationRequestModel.fromDto(msgDto as MsgHandleIdentityRecordsVerifyRequest);
      case MsgRequestIdentityRecordsVerify:
        return IRMsgRequestVerificationModel.fromDto(msgDto as MsgRequestIdentityRecordsVerify);
      default:
        return const MsgUndefinedModel();
    }
  }

  ATxMsg toMsgDto();

  Widget getIcon(TxDirectionType txDirectionType);

  List<PrefixedTokenAmountModel> getPrefixedTokenAmounts(TxDirectionType txDirectionType);

  String? getSubtitle(TxDirectionType txDirectionType);

  String getTitle(BuildContext context, TxDirectionType txDirectionType);
}
