import 'dart:convert';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:miro/shared/utils/crypto_address_parser.dart';
import 'package:pointycastle/export.dart';

class SignatureModel extends Equatable {
  final String signature;

  const SignatureModel({
    required this.signature,
  });

  factory SignatureModel.fromBytes(Uint8List signatureBytes) {
    return SignatureModel(
      signature: base64Encode(signatureBytes),
    );
  }

  ECSignature get ecSignature {
    final List<int> signatureBytes = base64Decode(signature);
    final List<int> rBytes = signatureBytes.sublist(0, 32);
    final List<int> sBytes = signatureBytes.sublist(32, 64);
    final BigInt r = CryptoAddressParser.bytesToInt(rBytes);
    final BigInt s = CryptoAddressParser.bytesToInt(sBytes);
    return ECSignature(r, s);
  }

  @override
  List<Object?> get props => <Object>[signature];
}
