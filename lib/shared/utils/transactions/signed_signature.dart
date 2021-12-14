import 'dart:convert';
import 'dart:typed_data';

import 'package:miro/infra/dto/api_cosmos/broadcast/request/transaction/components/tx_pub_key.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';
import 'package:miro/shared/utils/map_utils.dart';
import 'package:miro/shared/utils/transactions/message_signer.dart';
import 'package:miro/shared/utils/transactions/std_sign_doc.dart';
import 'package:pointycastle/export.dart';

/// Contains a result of [StdSignDoc] signing
class SignedSignature {
  /// Message signature
  final String signature;

  /// Signer public key
  final TxPubKey publicKey;

  SignedSignature._({
    required this.signature,
    required this.publicKey,
  });

  factory SignedSignature.sign({
    required StdSignDoc signDoc,
    required ECPrivateKey ecPrivateKey,
    required ECPublicKey ecPublicKey,
  }) {
    // Convert the signature to a JSON and sort it
    Map<String, dynamic> jsonSignature = MapUtils.sort(signDoc.toSignatureJson());

    // Encode the sorted JSON to a string and get the bytes
    String bodyData = json.encode(jsonSignature);
    final Uint8List bytes = Uint8List.fromList(utf8.encode(bodyData));

    // Sign the data
    final List<int> messageHash = Sha256.encrypt(utf8.decode(bytes)).bytes;
    Uint8List signatureData = MessageSigner.sign(
      Uint8List.fromList(messageHash),
      ecPrivateKey,
      ecPublicKey,
    );

    // Get the compressed Base64 public key
    final List<int> pubKeyCompressed = ecPublicKey.Q!.getEncoded(true);

    return SignedSignature._(
      signature: base64Encode(signatureData),
      publicKey: TxPubKey(key: base64Encode(pubKeyCompressed)),
    );
  }
}
