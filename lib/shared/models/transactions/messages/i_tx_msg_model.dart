import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/i_tx_msg.dart';

abstract class ITxMsgModel {
  ITxMsg toMsgDto();
}
