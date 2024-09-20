import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_entry_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/register/ir_msg_register_records_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class IRMsgRegisterRecordFormModel extends AMsgFormModel {
  // Form fields
  String? _identityKey;
  String? _identityValue;
  AWalletAddress? _senderWalletAddress;

  IRMsgRegisterRecordFormModel({
    String? identityKey,
    String? identityValue,
    AWalletAddress? senderWalletAddress,
  })  : _identityKey = identityKey,
        _identityValue = identityValue,
        _senderWalletAddress = senderWalletAddress;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_senderWalletAddress], [_identityKey] or [_identityValue]
  /// is not filled (equal null)
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build IRMsgRegisterRecordsModel. Form is not valid');
    }
    return IRMsgRegisterRecordsModel(
      walletAddress: _senderWalletAddress!,
      irEntryModels: <IREntryModel>[
        IREntryModel(
          key: _identityKey!,
          info: _identityValue!,
        ),
      ],
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = identityKey != null && _identityValue != null && _senderWalletAddress != null;
    return fieldsFilledBool;
  }

  String? get identityKey => _identityKey;

  set identityKey(String? value) {
    _identityKey = value;
    notifyListeners();
  }

  String? get identityValue => _identityValue;

  set identityValue(String? value) {
    _identityValue = value;
    notifyListeners();
  }

  AWalletAddress? get senderWalletAddress => _senderWalletAddress;

  set senderWalletAddress(AWalletAddress? value) {
    _senderWalletAddress = value;
    notifyListeners();
  }
}
