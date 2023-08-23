import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:hex/hex.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/utils/cryptography/secp256k1.dart';
import 'package:miro/shared/utils/transactions/signature_utils.dart';

/// research/interx-signature-verification
/// It will be useful to verify the account balances list and possibly account transactions list.
/// 1. Send request to interx
/// 2. Get response containing headers
/// 3. Basing on data from headers create ResponseSign object (documentation on notion)
/// https://www.notion.so/kira-network/Response-Signing-8a73ad521bff42898735fe252a880b09
/// 4. Create SHA256 checksum from ResponseSign object (point 3)
/// 5. Basing on checksum and interx_signature value get PublicKey used to create signature (provide these arguments into method)
/// 6. Get interx public key from /api/status and parse it to address
/// 8. Check if address from signature is equal downloaded interx address
///
/// This test expect that interx public key is equal:
///    02813B6B17BDBA3DB6AB44C51B7F0340B705A880D6E98D41B14AE107E9BA0E5B74
/// and the bech32 address is equal:
///    kira15gmk7pr6xlvnmet4g2qcyzt7edp4mwyjhaf894
/// Used interx address: http://173.212.254.147:11000
void main() {
  group('Tests of validating interx signature, if signature is valid', () {
    test('Should return true if Interx signature is valid', () {
      // Arrange
      Map<String, dynamic> responseSign = <String, dynamic>{
        'chain_id': 'testnet-9',
        'block': 3619572,
        'block_time': '2022-08-02T11:39:12.097786243Z',
        'timestamp': 1659440404,
        'response': 'f3dee00539419e3644f321f7c09753187a8e5763a289c18747bd64bc84feb49a',
      };
      String interxSignature = 'CaXLtKVZvrnYp+OIX30I3WX2QOXTWD7Qaw17qzrAiadUh8RaM5LuR7oruCKk47QfJeUD0RGRbfrTE0Q4wB4Zdw==';
      Uint8List interxResponseHashBytes = SignatureUtils.generateSignatureDataHashBytes(responseSign);
      Uint8List publicKeyBytes = Uint8List.fromList(HEX.decode('02813B6B17BDBA3DB6AB44C51B7F0340B705A880D6E98D41B14AE107E9BA0E5B74'));
      Uint8List addressBytes = Secp256k1.publicKeyToAddress(publicKeyBytes);

      // Act
      bool isSignatureValid = SignatureUtils.verifySignature(
        signatureModel: SignatureModel(signature: interxSignature),
        signatureDataHashBytes: interxResponseHashBytes,
        addressBytes: addressBytes,
      );

      // Assert
      expect(isSignatureValid, true);
    });
  });

  group('Tests of validating interx signature, if signature is invalid', () {
    test('Should return true if Interx signature is valid', () {
      // Arrange
      // Change any value from previous ResponseSign
      Map<String, dynamic> responseSign = <String, dynamic>{
        'chain_id': 'testnet-9',
        'block': 0,
        'block_time': '2022-08-02T11:39:12.097786243Z',
        'timestamp': 1659440404,
        'response': 'f3dee00539419e3644f321f7c09753187a8e5763a289c18747bd64bc84feb49a',
      };
      String interxSignature = 'CaXLtKVZvrnYp+OIX30I3WX2QOXTWD7Qaw17qzrAiadUh8RaM5LuR7oruCKk47QfJeUD0RGRbfrTE0Q4wB4Zdw==';
      Uint8List interxResponseHashBytes = SignatureUtils.generateSignatureDataHashBytes(responseSign);
      Uint8List publicKeyBytes = Uint8List.fromList(HEX.decode('02813B6B17BDBA3DB6AB44C51B7F0340B705A880D6E98D41B14AE107E9BA0E5B74'));
      Uint8List addressBytes = Secp256k1.publicKeyToAddress(publicKeyBytes);

      // Act
      bool isSignatureValid = SignatureUtils.verifySignature(
        signatureModel: SignatureModel(signature: interxSignature),
        signatureDataHashBytes: interxResponseHashBytes,
        addressBytes: addressBytes,
      );

      // Assert
      expect(isSignatureValid, false);
    });
  });
}
