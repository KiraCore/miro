import 'package:flutter/cupertino.dart';
import 'package:miro/infra/dto/api_cosmos/broadcast/request/messages/msg_send.dart';
import 'package:miro/shared/models/tokens/token_amount.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_form_controller.dart';
import 'package:miro/views/pages/dialog/transactions/widgets/msg_form/msg_send_form/msg_send_form_model.dart';

class MsgSendFormController extends MsgFormController<MsgSend> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final MsgSendFormModel msgSendFormModel = MsgSendFormModel();

  MsgSendFormController({
    required String fee,
  }) : super(fee: fee);

  @override
  String? getErrorMessage() {
    return msgSendFormModel.getErrorMessage();
  }

  @override
  MsgSend? getTransactionMessage() {
    return msgSendFormModel.buildTransactionMessage();
  }

  @override
  String? getMemo() {
    String currentMemo = msgSendFormModel.memoTextEditingController.text;
    if (currentMemo.isEmpty) {
      return 'MsgSend';
    } else {
      return currentMemo;
    }
  }

  void setSenderWalletAddress(WalletAddress? walletAddress) {
    msgSendFormModel.fromWalletAddressNotifier.value = walletAddress;
  }

  void setRecipientWalletAddress(WalletAddress? walletAddress) {
    msgSendFormModel.toWalletAddress = walletAddress;
  }

  void setTokenAmount(TokenAmount? tokenAmount) {
    msgSendFormModel.tokenAmount = tokenAmount;
  }
}
