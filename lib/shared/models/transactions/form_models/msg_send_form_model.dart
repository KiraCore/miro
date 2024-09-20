import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class MsgSendFormModel extends AMsgFormModel {
  // Form fields
  AWalletAddress? _recipientWalletAddress;
  AWalletAddress? _senderWalletAddress;
  TokenAmountModel? _tokenAmountModel;

  // Values required to be saved to allow editing transaction
  BalanceModel? balanceModel;
  TokenDenominationModel? tokenDenominationModel;

  MsgSendFormModel({
    AWalletAddress? recipientWalletAddress,
    AWalletAddress? senderWalletAddress,
    TokenAmountModel? tokenAmountModel,
    this.balanceModel,
    this.tokenDenominationModel,
  })  : _senderWalletAddress = senderWalletAddress,
        _recipientWalletAddress = recipientWalletAddress,
        _tokenAmountModel = tokenAmountModel;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_senderWalletAddress], [_recipientWalletAddress] or [_tokenAmountModel]
  /// is not filled (equal null) or [_tokenAmountModel] has amount equal 0.
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build MsgSendModel. Form is not valid');
    }
    return MsgSendModel(
      fromWalletAddress: _senderWalletAddress!,
      toWalletAddress: _recipientWalletAddress!,
      tokenAmountModel: _tokenAmountModel!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = _senderWalletAddress != null && _recipientWalletAddress != null && _tokenAmountModel != null;
    bool tokenAmountNotEmptyBool = _tokenAmountModel?.getAmountInNetworkDenomination() != Decimal.zero;
    if (fieldsFilledBool && tokenAmountNotEmptyBool) {
      return true;
    } else {
      return false;
    }
  }

  AWalletAddress? get recipientWalletAddress => _recipientWalletAddress;

  set recipientWalletAddress(AWalletAddress? recipientWalletAddress) {
    _recipientWalletAddress = recipientWalletAddress;
    notifyListeners();
  }

  AWalletAddress? get senderWalletAddress => _senderWalletAddress;

  set senderWalletAddress(AWalletAddress? senderWalletAddress) {
    _senderWalletAddress = senderWalletAddress;
    notifyListeners();
  }

  TokenAmountModel? get tokenAmountModel => _tokenAmountModel;

  set tokenAmountModel(TokenAmountModel? tokenAmountModel) {
    _tokenAmountModel = tokenAmountModel;
    notifyListeners();
  }
}
