import 'package:flutter/widgets.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/messages/tx_msg_type.dart';
import 'package:miro/shared/models/transactions/tx_local_info_model.dart';
import 'package:miro/views/pages/transactions/tx_confirm_page/form_previews/msg_send_form_preview.dart';

class TxConfirmFormPreview extends StatelessWidget {
  final TxLocalInfoModel txLocalInfoModel;
  final TokenDenominationModel? tokenDenominationModel;

  const TxConfirmFormPreview({
    required this.txLocalInfoModel,
    this.tokenDenominationModel,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TxMsgType txMsgType = txLocalInfoModel.txMsgModel.txMsgType;
    switch (txMsgType) {
      case TxMsgType.msgSend:
        return MsgSendFormPreview(
          txLocalInfoModel: txLocalInfoModel,
          tokenDenominationModel: tokenDenominationModel,
        );
      default:
        return Text('Preview for ${txMsgType} unavailable');
    }
  }
}
