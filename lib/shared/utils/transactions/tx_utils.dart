import 'dart:convert';

import 'package:miro/infra/dto/api_kira/broadcast/request/transaction/std_sign_doc.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/transactions/signed_transaction_model.dart';
import 'package:miro/shared/models/transactions/unsigned_tx_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/map_utils.dart';
import 'package:miro/shared/utils/transactions/signature_utils.dart';

class TxUtils {
  static Map<String, String> memoReplacements = <String, String>{
    '<': r'\u003c',
    '>': r'\u003e',
  };

  static String trimMemoToLength(String rawMemo, int maxLength) {
    String trimmedMemo = rawMemo;
    String replacedMemo = TxUtils.replaceMemoRestrictedChars(trimmedMemo);
    while(replacedMemo.length > maxLength) {
      trimmedMemo = trimmedMemo.substring(0, trimmedMemo.length - 1);
      replacedMemo = TxUtils.replaceMemoRestrictedChars(trimmedMemo);
    }
    return trimmedMemo;
  }

  static String replaceMemoRestrictedChars(String memo) {
    String replacedMemo = memo;
    memoReplacements.forEach((String pattern, String replacement) {
      replacedMemo = replacedMemo.replaceAll(pattern, replacement);
    });
    return replacedMemo;
  }

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
