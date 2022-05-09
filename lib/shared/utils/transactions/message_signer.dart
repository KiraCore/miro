import 'dart:convert';
import 'dart:typed_data';

import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/shared/utils/cryptography/secp256k1.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';
import 'package:miro/shared/utils/map_utils.dart';
import 'package:pointycastle/ecc/api.dart';
import 'package:pointycastle/ecc/curves/secp256k1.dart';
import 'package:pointycastle/export.dart';
import 'package:pointycastle/signers/ecdsa_signer.dart';

/// Helper class used to sign a transaction.
/// Source: https://github.com/KiraCore/tools/blob/2f79a4788f1614d9ed56b4878d5b5d8005af51b2/offline-signer/tx_helper/msg_signer.dart
class MessageSigner {
  static final BigInt? _prime = BigInt.tryParse(
    'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
    radix: 16,
  );

  static Uint8List sign(
    Uint8List message,
    ECPrivateKey privateKey,
    ECPublicKey publicKey,
  ) {
    final ECDomainParameters _params = ECCurve_secp256k1();
    final BigInt _halfCurveOrder = _params.n >> 1;

    final ECDSASigner ecdsaSigner = ECDSASigner(null, HMac(SHA256Digest(), 64))
      ..init(true, PrivateKeyParameter<PrivateKey>(privateKey));

    ECSignature ecSignature = ecdsaSigner.generateSignature(message) as ECSignature;

    if (ecSignature.s.compareTo(_halfCurveOrder) > 0) {
      final BigInt canonicalS = _params.n - ecSignature.s;
      ecSignature = ECSignature(ecSignature.r, canonicalS);
    }

    final Uint8List publicKeyBytes = publicKey.Q!.getEncoded();
    final Uint8List address = Secp256k1.publicKeyToAddress(publicKeyBytes);
    bool signatureValid = _validateSignature(address, ecSignature, message);
    if (!signatureValid) {
      throw Exception('Invalid signature');
    }

    Uint8List signatureBytes = Uint8List.fromList(
      CryptoAddressParser.intToBytes(ecSignature.r) + CryptoAddressParser.intToBytes(ecSignature.s),
    );

    return signatureBytes;
  }

  static bool validateRawSignature({
    required Uint8List address,
    required String signature,
    required Map<String, dynamic> message,
  }) {
    try {
      Uint8List signatureBytes = base64Decode(signature);

      ECSignature ecSignature = ECSignature(
        CryptoAddressParser.bytesToInt(signatureBytes.sublist(0, 32)),
        CryptoAddressParser.bytesToInt(signatureBytes.sublist(32, 64)),
      );

      Map<String, dynamic> jsonSignature = MapUtils.sort(message);
      String bodyData = json.encode(jsonSignature);
      final Uint8List bytes = Uint8List.fromList(utf8.encode(bodyData));
      final List<int> messageHash = Sha256.encrypt(utf8.decode(bytes)).bytes;

      return _validateSignature(address, ecSignature, Uint8List.fromList(messageHash));
    } catch (_) {
      return false;
    }
  }

  static bool _validateSignature(Uint8List address, ECSignature ecSignature, Uint8List message) {
    final ECDomainParameters _params = ECCurve_secp256k1();
    final BigInt addressBytes = CryptoAddressParser.bytesToInt(address);
    for (int i = 0; i < 4; i++) {
      final Uint8List? k = _recoverFromSignature(i, ecSignature, message, _params);
      if (k == null) {
        continue;
      }
      final Uint8List kAddressBytes = Secp256k1.publicKeyToAddress(k);
      final BigInt kAddresInt = CryptoAddressParser.bytesToInt(kAddressBytes);
      if (kAddresInt == addressBytes) {
        return true;
      }
    }
    return false;
  }

  static Uint8List? _recoverFromSignature(int recId, ECSignature sig, Uint8List msg, ECDomainParameters params) {
    final BigInt n = params.n;
    final BigInt i = BigInt.from(recId ~/ 2);
    final BigInt x = sig.r + (i * n);

    if (x.compareTo(_prime!) >= 0) {
      return null;
    }

    final ECPoint R = _decompressKey(x, (recId & 1) == 1, params.curve)!;
    if (!(R * n)!.isInfinity) {
      return null;
    }

    final BigInt e = CryptoAddressParser.bytesToInt(msg);

    final BigInt eInv = (BigInt.zero - e) % n;
    final BigInt rInv = sig.r.modInverse(n);
    final BigInt srInv = (rInv * sig.s) % n;
    final BigInt eInvrInv = (rInv * eInv) % n;

    final ECPoint? q = (params.G * eInvrInv)! + (R * srInv);

    final Uint8List bytes = q!.getEncoded();
    return bytes;
  }

  static ECPoint? _decompressKey(BigInt xBN, bool yBit, ECCurve c) {
    List<int> x9IntegerToBytes(BigInt s, int qLength) {
      final Uint8List bytes = CryptoAddressParser.intToBytes(s);

      if (qLength < bytes.length) {
        return bytes.sublist(0, bytes.length - qLength);
      } else if (qLength > bytes.length) {
        final List<int> tmp = List<int>.filled(qLength, 0);

        final int offset = qLength - bytes.length;
        for (int i = 0; i < bytes.length; i++) {
          tmp[i + offset] = bytes[i];
        }
        return tmp;
      }

      return bytes;
    }

    final List<int> compEnc = x9IntegerToBytes(xBN, 1 + ((c.fieldSize + 7) ~/ 8));
    compEnc[0] = yBit ? 0x03 : 0x02;
    return c.decodePoint(compEnc);
  }
}
