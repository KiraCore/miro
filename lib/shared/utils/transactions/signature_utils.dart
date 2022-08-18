import 'dart:convert';
import 'dart:typed_data';

import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:miro/shared/utils/cryptography/secp256k1.dart';
import 'package:miro/shared/utils/cryptography/sha256.dart';
import 'package:pointycastle/export.dart';

class SignatureUtils {
  static final BigInt _prime = BigInt.parse(
    'fffffffffffffffffffffffffffffffffffffffffffffffffffffffefffffc2f',
    radix: 16,
  );

  static SignatureModel generateSignature({required Wallet wallet, required Map<String, dynamic> signatureDataJson}) {
    final Uint8List signatureDataHashBytes = generateSignatureDataHashBytes(signatureDataJson);

    final ECDomainParameters ecDomainParameters = ECCurve_secp256k1();
    final BigInt halfCurveOrder = ecDomainParameters.n >> 1;

    final ECDSASigner ecdsaSigner = ECDSASigner(null, HMac(SHA256Digest(), 64))
      ..init(true, PrivateKeyParameter<PrivateKey>(wallet.ecPrivateKey));

    ECSignature ecSignature = ecdsaSigner.generateSignature(signatureDataHashBytes) as ECSignature;

    if (ecSignature.s.compareTo(halfCurveOrder) > 0) {
      final BigInt canonicalS = ecDomainParameters.n - ecSignature.s;
      ecSignature = ECSignature(ecSignature.r, canonicalS);
    }

    Uint8List signatureBytes = Uint8List.fromList(
      CryptoAddressParser.intToBytes(ecSignature.r) + CryptoAddressParser.intToBytes(ecSignature.s),
    );

    return SignatureModel.fromBytes(signatureBytes);
  }

  static Uint8List generateSignatureDataHashBytes(Map<String, dynamic> signatureDataJson) {
    final String signatureDataString = json.encode(signatureDataJson);
    final List<int> signatureDataHash = Sha256.encrypt(signatureDataString).bytes;
    return Uint8List.fromList(signatureDataHash);
  }

  static bool verifySignature({
    required SignatureModel signatureModel,
    required Uint8List addressBytes,
    required Uint8List signatureDataHashBytes,
  }) {
    List<Uint8List> signaturePublicKeyList = _extractPublicKeysFromSignature(signatureModel.ecSignature, signatureDataHashBytes);
    if (signaturePublicKeyList.isEmpty) {
      return false;
    }
    final BigInt expectedAddress = CryptoAddressParser.bytesToInt(addressBytes);

    for (Uint8List signaturePublicKey in signaturePublicKeyList) {
      final Uint8List actualAddressBytes = Secp256k1.publicKeyToAddress(signaturePublicKey);
      final BigInt actualAddress = CryptoAddressParser.bytesToInt(actualAddressBytes);
      final bool addressesEqual = actualAddress == expectedAddress;
      if (addressesEqual) {
        return true;
      }
    }
    return false;
  }

  static List<Uint8List> _extractPublicKeysFromSignature(ECSignature ecSignature, Uint8List messageHashBytes) {
    try {
      final List<Uint8List> generatedPublicKeys = List<Uint8List>.empty(growable: true);
      for (int recoveryId = 0; recoveryId < 4; recoveryId++) {
        Uint8List? publicKey = _recoverFromSignature(recoveryId, ecSignature, messageHashBytes);
        if (publicKey != null) {
          generatedPublicKeys.add(publicKey);
        }
      }
      return generatedPublicKeys;
    } catch (_) {
      return List<Uint8List>.empty();
    }
  }

  static Uint8List? _recoverFromSignature(int recoveryId, ECSignature ecSignature, Uint8List messageHashBytes) {
    final ECDomainParameters params = ECCurve_secp256k1();

    final BigInt n = params.n;
    final BigInt i = BigInt.from(recoveryId ~/ 2);
    final BigInt x = ecSignature.r + (i * n);

    if (x.compareTo(_prime) >= 0) {
      return null;
    }

    final ECPoint R = _decompressKey(x, (recoveryId & 1) == 1, params.curve)!;
    if (!(R * n)!.isInfinity) {
      return null;
    }

    final BigInt e = CryptoAddressParser.bytesToInt(messageHashBytes);

    final BigInt eInv = (BigInt.zero - e) % n;
    final BigInt rInv = ecSignature.r.modInverse(n);
    final BigInt srInv = (rInv * ecSignature.s) % n;
    final BigInt eInvrInv = (rInv * eInv) % n;

    final ECPoint? q = (params.G * eInvrInv)! + (R * srInv);

    final Uint8List bytes = q!.getEncoded();
    return bytes;
  }

  static ECPoint? _decompressKey(BigInt xBN, bool yBit, ECCurve ecCurve) {
    final int qLength = 1 + ((ecCurve.fieldSize + 7) ~/ 8);
    final List<int> compEnc = _x9IntegerToBytes(xBN, qLength);
    compEnc[0] = yBit ? 0x03 : 0x02;
    return ecCurve.decodePoint(compEnc);
  }

  static List<int> _x9IntegerToBytes(BigInt s, int qLength) {
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
}
