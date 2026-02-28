import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class InterxMsgTypes {
  static final Map<TxMsgType, String> _types = <TxMsgType, String>{
    TxMsgType.msgCancelIdentityRecordsVerifyRequest: 'cancel_identity_records_verify_request',
    TxMsgType.msgClaimRewards: 'claim_rewards',
    TxMsgType.msgClaimUndelegation: 'claim_undelegation',
    TxMsgType.msgDelegate: 'delegate',
    TxMsgType.msgDeleteIdentityRecords: 'edit_identity_record',
    TxMsgType.msgHandleIdentityRecordsVerifyRequest: 'handle_identity_records_verify_request',
    TxMsgType.msgRegisterIdentityRecords: 'register_identity_records',
    TxMsgType.msgRequestIdentityRecordsVerify: 'request_identity_records_verify',
    TxMsgType.msgSend: 'send',
    TxMsgType.msgUndelegate: 'undelegate',
  };

  static String getName(TxMsgType type) => _types[type] ?? '';

  static TxMsgType getType(String name) {
    return _types.keys.firstWhere((TxMsgType type) {
      return _types[type] == name;
    }, orElse: () {
      return TxMsgType.undefined;
    });
  }
}
