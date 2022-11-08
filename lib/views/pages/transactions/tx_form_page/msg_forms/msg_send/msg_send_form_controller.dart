import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/views/pages/transactions/tx_form_page/msg_forms/a_msg_form_controller.dart';

class MsgSendFormController extends AMsgFormController {
  String? _memo;

  WalletAddress? _senderWalletAddress;
  WalletAddress? _recipientWalletAddress;
  TokenAmountModel? _tokenAmountModel;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields: 
  /// [_senderWalletAddress], [_recipientWalletAddress] or [_tokenAmountModel]
  /// is not filled (equal null)
  @override
  ATxMsgModel buildTxMsgModel() {
    formKey.currentState?.validate();
    bool formFilled = formFilledNotifier.value;
    if (formFilled) {
      return MsgSendModel(
        fromWalletAddress: _senderWalletAddress!,
        toWalletAddress: _recipientWalletAddress!,
        tokenAmountModel: _tokenAmountModel!,
      );
    } else {
      throw Exception('Cannot build MsgSendModel. Form is not valid');
    }
  }

  @override
  String get memo {
    return _memo ?? '';
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
