import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/i_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/transactions/a_tx_msg_form_controller.dart';

class MsgSendFormController extends ATxMsgFormController {
  String? _memo;

  WalletAddress? _senderWalletAddress;
  WalletAddress? _recipientWalletAddress;
  TokenAmountModel? _tokenAmountModel;

  @override
  ITxMsgModel? buildTxMsgModel() {
    if (formKey.currentState == null) {
      return null;
    }
    bool formValid = formKey.currentState?.validate() ?? false;
    if (formValid) {
      return MsgSendModel(
        fromWalletAddress: _senderWalletAddress!,
        toWalletAddress: _recipientWalletAddress!,
        tokenAmountModel: _tokenAmountModel!,
      );
    } else {
      return null;
    }
  }

  @override
  String get memo {
    return _memo ?? 'MsgSend from ${_senderWalletAddress?.bech32Address} to ${_recipientWalletAddress?.bech32Address}';
  }

  set memo(String? memo) {
    _memo = memo;
  }

  set senderWalletAddress(WalletAddress? senderWalletAddress) {
    _senderWalletAddress = senderWalletAddress;
    _validateFormFilled();
  }

  set recipientWalletAddress(WalletAddress? recipientWalletAddress) {
    _recipientWalletAddress = recipientWalletAddress;
    _validateFormFilled();
  }

  set tokenAmountModel(TokenAmountModel? tokenAmountModel) {
    _tokenAmountModel = tokenAmountModel;
    _validateFormFilled();
  }

  void _validateFormFilled() {
    if (_senderWalletAddress != null && _recipientWalletAddress != null && _tokenAmountModel != null) {
      formFilledNotifier.value = true;
    } else {
      formFilledNotifier.value = false;
    }
  }
}
