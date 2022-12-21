import 'dart:convert';

import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/std_sign_doc.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/map_utils.dart';
import 'package:miro/shared/utils/transactions/signature_utils.dart';

class TxSigner {
  static SignedTxModel sign({required UnsignedTxModel unsignedTxModel, required Wallet wallet}) {
    StdSignDoc stdSignDoc = StdSignDoc.fromUnsignedTxModel(unsignedTxModel);
    Map<String, dynamic> signatureDataJson = MapUtils.sort(stdSignDoc.toSignatureJson());
    SignatureModel signatureModel = SignatureUtils.generateSignature(wallet: wallet, signatureDataJson: signatureDataJson);
    List<int> publicKeyCompressed = wallet.ecPublicKey.Q!.getEncoded(true);

    return SignedTxModel(
      publicKeyCompressed: base64Encode(publicKeyCompressed),
      txLocalInfoModel: unsignedTxModel.txLocalInfoModel,
      txRemoteInfoModel: unsignedTxModel.txRemoteInfoModel,
      signatureModel: signatureModel,
    );
  }
}
