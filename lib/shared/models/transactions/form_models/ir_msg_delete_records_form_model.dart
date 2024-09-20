import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_delete_records_model.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';

class IRMsgDeleteRecordsFormModel extends AMsgFormModel {
  // Form fields
  List<IRRecordModel>? _irRecordModels;
  AWalletAddress? _walletAddress;

  IRMsgDeleteRecordsFormModel({
    List<IRRecordModel>? irRecordModels,
    AWalletAddress? walletAddress,
  })  : _irRecordModels = irRecordModels,
        _walletAddress = walletAddress;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_irRecordModels] or [_walletAddress]
  /// is not filled (equal null) or [_tokenAmountModel] has amount equal 0.
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build IRMsgDeleteRecordsModel. Form is not valid');
    }
    return IRMsgDeleteRecordsModel(
      keys: _irRecordModels!.map((IRRecordModel e) => e.key).toList(),
      walletAddress: _walletAddress!,
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = _irRecordModels != null && _walletAddress != null;
    return fieldsFilledBool;
  }

  List<IRRecordModel>? get irRecordsModels => _irRecordModels;

  set irRecordsModels(List<IRRecordModel>? irRecordModels) {
    _irRecordModels = irRecordModels;
    notifyListeners();
  }

  AWalletAddress? get walletAddress => _walletAddress;

  set walletAddress(AWalletAddress? walletAddress) {
    _walletAddress = walletAddress;
    notifyListeners();
  }
}
