import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

class InterxMsgTypes {
  static final Map<TxMsgType, String> _types = <TxMsgType, String>{
    TxMsgType.msgCancelIdentityRecordsVerifyRequest: 'cancel-identity-records-verify-request',
    TxMsgType.msgDeleteIdentityRecords: 'edit-identity-record',
    TxMsgType.msgHandleIdentityRecordsVerifyRequest: 'handle-identity-records-verify-request',
    TxMsgType.msgRegisterIdentityRecords: 'register-identity-records',
    TxMsgType.msgRequestIdentityRecordsVerify: 'request-identity-records-verify',
    TxMsgType.msgSend: 'send',
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
