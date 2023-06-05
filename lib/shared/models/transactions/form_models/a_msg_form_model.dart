import 'package:flutter/material.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';

abstract class AMsgFormModel extends ChangeNotifier {
  String memo = '';

  /// Method [buildTxMsgModel] throws [Exception] if cannot create ATxMsgModel
  /// Broader explanation about reason of thrown exception should be described in specific implementations of this method
  ATxMsgModel buildTxMsgModel();

  bool canBuildTxMsg();
}
