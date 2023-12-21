import 'package:decimal/decimal.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/models/transactions/form_models/a_msg_form_model.dart';
import 'package:miro/shared/models/transactions/messages/a_tx_msg_model.dart';
import 'package:miro/shared/models/transactions/messages/identity_registrar/ir_msg_request_verification_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';

class IRMsgRequestVerificationFormModel extends AMsgFormModel {
  // Form fields
  final IRRecordModel _irRecordModel;
  TokenAmountModel? _tipTokenAmountModel;
  WalletAddress? _requesterWalletAddress;
  WalletAddress? _verifierWalletAddress;

  // Values required to be saved to allow editing transaction
  BalanceModel? balanceModel;
  TokenDenominationModel? tokenDenominationModel;

  IRMsgRequestVerificationFormModel({
    required IRRecordModel irRecordModel,
    TokenAmountModel? tipTokenAmountModel,
    WalletAddress? requesterWalletAddress,
    WalletAddress? verifierWalletAddress,
    this.balanceModel,
  })  : _irRecordModel = irRecordModel,
        _tipTokenAmountModel = tipTokenAmountModel,
        _requesterWalletAddress = requesterWalletAddress,
        _verifierWalletAddress = verifierWalletAddress;

  /// Method [buildTxMsgModel] throws [Exception] if at least one of the fields:
  /// [_requesterWalletAddress], [_verifierWalletAddress], [_identityRecordId] or [_tipTokenAmountModel]
  /// is not filled (equal null)
  @override
  ATxMsgModel buildTxMsgModel() {
    bool messageFilledBool = canBuildTxMsg();
    if (messageFilledBool == false) {
      throw Exception('Cannot build IRMsgRequestVerificationModel. Form is not valid');
    }
    return IRMsgRequestVerificationModel(
      walletAddress: _requesterWalletAddress!,
      verifierWalletAddress: _verifierWalletAddress!,
      tipTokenAmountModel: _tipTokenAmountModel!,
      recordIds: <BigInt>[
        BigInt.parse(_irRecordModel.id),
      ],
    );
  }

  @override
  bool canBuildTxMsg() {
    bool fieldsFilledBool = _tipTokenAmountModel != null && _requesterWalletAddress != null && _verifierWalletAddress != null;
    bool tipAmountNotEmptyBool = _tipTokenAmountModel?.getAmountInNetworkDenomination() != Decimal.zero;
    return fieldsFilledBool && tipAmountNotEmptyBool;
  }

  IRRecordModel get irRecordModel => _irRecordModel;

  TokenAmountModel? get tipTokenAmountModel => _tipTokenAmountModel;

  set tipTokenAmountModel(TokenAmountModel? tipTokenAmountModel) {
    _tipTokenAmountModel = tipTokenAmountModel;
    notifyListeners();
  }

  WalletAddress? get requesterWalletAddress => _requesterWalletAddress;

  set requesterWalletAddress(WalletAddress? requesterWalletAddress) {
    _requesterWalletAddress = requesterWalletAddress;
    notifyListeners();
  }

  WalletAddress? get verifierWalletAddress => _verifierWalletAddress;

  set verifierWalletAddress(WalletAddress? verifierWalletAddress) {
    _verifierWalletAddress = verifierWalletAddress;
    notifyListeners();
  }
}
