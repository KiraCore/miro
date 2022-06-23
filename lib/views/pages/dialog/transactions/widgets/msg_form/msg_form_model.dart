import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/tx_msg.dart';

abstract class MsgFormModel<MessageType extends TxMsg> {
  MessageType toTxMsg();

  bool hasData();

  String? get memo;
}
