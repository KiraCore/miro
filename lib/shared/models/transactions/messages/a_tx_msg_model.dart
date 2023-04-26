import 'package:equatable/equatable.dart';
import 'package:miro/infra/dto/shared/messages/a_tx_msg.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';

abstract class ATxMsgModel extends Equatable {
  final TxMsgType txMsgType;

  const ATxMsgModel({
    required this.txMsgType,
  });

  ATxMsg toMsgDto();
}
