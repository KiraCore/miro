import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/msg_send_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class MockMsgFormModel extends AMsgFormModel {
  static ATxMsgModel mockTxMsgModel = MsgSendModel(
    fromWalletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    toWalletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    tokenAmountModel: TokenAmountModel(
      defaultDenominationAmount: Decimal.parse('1'),
      tokenAliasModel: TokenAliasModel.local('ukex'),
    ),
  );

  String? requiredField;
  String? notRequiredField;

  MockMsgFormModel({
    this.requiredField,
    this.notRequiredField,
  });

  /// Method [buildTxMsgModel] throws [Exception] if [requiredField] is empty
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build MsgSendModel. Form is not valid');
    }
    return mockTxMsgModel;
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = requiredField != null;
    if (fieldsFilledBool) {
      return true;
    } else {
      return false;
    }
  }
}
