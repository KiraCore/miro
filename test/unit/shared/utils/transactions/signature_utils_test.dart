import 'dart:typed_data';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/models/transactions/signature_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/transactions/signature_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

void main() {
  Wallet actualWallet = TestUtils.wallet;

  final Map<String, dynamic> txStdSignDocJson = <String, dynamic>{
    'account_number': '669',
    'chain_id': 'testnet',
    'fee': <String, dynamic>{
      'amount': <Map<String, dynamic>>[
        <String, dynamic>{'amount': '100', 'denom': 'ukex'}
      ],
      'gas': '999999'
    },
    'memo': 'Test transaction',
    'msgs': <Map<String, dynamic>>[
      <String, dynamic>{
        'type': 'cosmos-sdk/MsgSend',
        'value': <String, dynamic>{
          'amount': <Map<String, dynamic>>[
            <String, dynamic>{'amount': '100', 'denom': 'ukex'}
          ],
          'from_address': 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
          'to_address': 'kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'
        }
      }
    ],
    'sequence': '5'
  };

  final Map<String, dynamic> queryAccountResponse = <String, dynamic>{
    'account': <String, dynamic>{
      '@type': '/cosmos.auth.v1beta1.BaseAccount',
      'account_number': '669',
      'address': 'a2lyYTE0M3E4dnhwdnV5a3Q5cHE1MGU2aG5nOXMzOHZteTg0NG44azl3eA==',
      'pub_key': 'Ch8vY29zbW9zLmNyeXB0by5zZWNwMjU2azEuUHViS2V5EiMKIQJS2rPAiepZucmSfIdFOULvZ81b4L7JIB7lETwd471MfA==',
      'sequence': '96'
    }
  };

  Map<String, dynamic> queryAccountResponseSign = <String, dynamic>{
    'chain_id': 'testnet-9',
    'block': 3914180,
    'block_time': '2022-08-22T10:43:05.682448427Z',
    'timestamp': 1661165056,
    'response': '4da7ce0f135eef0854cc07a1c5d964644769ea409cde2f939af964074278a1e5',
  };

  // @formatter:off

  // 4e1b257c7e926d7881a8838aa6b8a675c6e8a208591b21598a3c1dd1313849b9
  Uint8List stdTxSignDocHashBytes = Uint8List.fromList(<int>[78, 27, 37, 124, 126, 146, 109, 120, 129, 168, 131, 138, 166, 184, 166, 117, 198, 232, 162, 8, 89, 27, 33, 89, 138, 60, 29, 209, 49, 56, 73, 185]);

  // 4da7ce0f135eef0854cc07a1c5d964644769ea409cde2f939af964074278a1e5
  Uint8List queryAccountResponseHashBytes = Uint8List.fromList(<int>[77, 167, 206, 15, 19, 94, 239, 8, 84, 204, 7, 161, 197, 217, 100, 100, 71, 105, 234, 64, 156, 222, 47, 147, 154, 249, 100, 7, 66, 120, 161, 229]);

  // c25798e59c3c362f40961c2d6e9aaa4be8f229511500423b84b2bb3ac9f3603c
  Uint8List queryAccountResponseSignHashBytes = Uint8List.fromList(<int>[194, 87, 152, 229, 156, 60, 54, 47, 64, 150, 28, 45, 110, 154, 170, 75, 232, 242, 41, 81, 21, 0, 66, 59, 132, 178, 187, 58, 201, 243, 96, 60]);

  // @formatter:on

  group('Tests of SignatureUtils.generateSignature() method', () {
    test('Should return signature for specified json', () {
      // Act
      SignatureModel actualSignatureModel = SignatureUtils.generateSignature(
        wallet: actualWallet,
        signatureDataJson: txStdSignDocJson,
      );

      // Assert
      SignatureModel expectedSignatureModel = const SignatureModel(
        signature: 'GJbeZ35afeBr7XVmclweWEqUE9+QZ/urq52n8wzvEZxGHwvpcSJfyY4SV4DSo4q7IMJjxkol6DTHq/Zlyj4jZA==',
      );

      expect(actualSignatureModel, expectedSignatureModel);
    });
  });

  group('Tests of SignatureUtils.generateSignatureDataHash() method', () {
    test('Should encrypt StdSignDoc via SHA256 algorithm', () {
      // Act
      Uint8List actualSignatureDataHashBytes = SignatureUtils.generateSignatureDataHashBytes(txStdSignDocJson);

      // Assert
      Uint8List expectedSignatureDataHashBytes = stdTxSignDocHashBytes;

      expect(actualSignatureDataHashBytes, expectedSignatureDataHashBytes);
    });

    test('Should encrypt Interx Response via SHA256 algorithm', () {
      // Act
      Uint8List actualSignatureDataHashBytes = SignatureUtils.generateSignatureDataHashBytes(queryAccountResponse);

      // Assert
      Uint8List expectedSignatureDataHashBytes = queryAccountResponseHashBytes;

      expect(actualSignatureDataHashBytes, expectedSignatureDataHashBytes);
    });

    test('Should encrypt Interx Response Sign via SHA256 algorithm', () {
      // Act
      Uint8List actualSignatureDataHashBytes = SignatureUtils.generateSignatureDataHashBytes(queryAccountResponseSign);
      
      // Assert
      Uint8List expectedSignatureDataHashBytes = queryAccountResponseSignHashBytes;

      expect(actualSignatureDataHashBytes, expectedSignatureDataHashBytes);
    });
  });

  group('Tests of SignatureUtils.verifySignature() method', () {
    test('Should return true if transaction signature was created with provided address', () {
      // Arrange
      SignatureModel signatureModel = const SignatureModel(
        signature: 'GJbeZ35afeBr7XVmclweWEqUE9+QZ/urq52n8wzvEZxGHwvpcSJfyY4SV4DSo4q7IMJjxkol6DTHq/Zlyj4jZA==',
      );

      Uint8List addressBytes = actualWallet.address.addressBytes;

      // Act
      bool actualSignatureValid = SignatureUtils.verifySignature(
        addressBytes: addressBytes,
        signatureDataHashBytes: stdTxSignDocHashBytes,
        signatureModel: signatureModel,
      );

      // Assert
      expect(actualSignatureValid, true);
    });

    test('Should return false if transaction signature was not created with provided address', () {
      // Arrange
      SignatureModel signatureModel = const SignatureModel(
        signature: 'CybmU4aM0mgcULqYsQOjYXiR8uWMD7axfyz0vT9nNqQNrN7wXAOiWMcnCFsCbFONKIpMrHcxSVLEZxLh3p34Tg==',
      );

      Uint8List addressBytes = actualWallet.address.addressBytes;

      // Act
      bool actualSignatureValid = SignatureUtils.verifySignature(
        addressBytes: addressBytes,
        signatureDataHashBytes: stdTxSignDocHashBytes,
        signatureModel: signatureModel,
      );

      // Assert
      expect(actualSignatureValid, false);
    });

    test('Should return true if response signature was created with provided validator address', () {
      // Arrange
      SignatureModel signatureModel = const SignatureModel(
        signature: 'Qg7gb8rnRXaxIVMwqadPb0HkZnnWhHSmVZRRGAITZ7p3rFcsA1cj3CF8iKsHQ1lOYUoDru1IUm//0oNB+0LceQ==',
      );

      // Uint8List publicKeyBytes = Uint8List.fromList(HEX.decode('02813B6B17BDBA3DB6AB44C51B7F0340B705A880D6E98D41B14AE107E9BA0E5B74'));
      // Uint8List addressBytes = Secp256k1.publicKeyToAddress(publicKeyBytes);

      WalletAddress walletAddress = WalletAddress.fromBech32('kira15gmk7pr6xlvnmet4g2qcyzt7edp4mwyjhaf894');
      Uint8List addressBytes = walletAddress.addressBytes;

      // Act
      bool actualSignatureValid = SignatureUtils.verifySignature(
        addressBytes: addressBytes,
        signatureDataHashBytes: queryAccountResponseSignHashBytes,
        signatureModel: signatureModel,
      );

      // Assert
      expect(actualSignatureValid, true);
    });

    test('Should return false if response signature was not created with provided validator address', () {
      // Arrange
      SignatureModel signatureModel = const SignatureModel(
        signature: 'bMfNtQHLWT6TcazOfCTm6u1UG5s9DygWfNLG5e0WWvQUmPzfu3f/TB0wyhOfVjgo+DcTQbZ3iJp0X3KVZ2mheg==',
      );

      // Uint8List publicKeyBytes = Uint8List.fromList(HEX.decode('02813B6B17BDBA3DB6AB44C51B7F0340B705A880D6E98D41B14AE107E9BA0E5B74'));
      // Uint8List addressBytes = Secp256k1.publicKeyToAddress(publicKeyBytes);

      WalletAddress walletAddress = WalletAddress.fromBech32('kira15gmk7pr6xlvnmet4g2qcyzt7edp4mwyjhaf894');
      Uint8List addressBytes = walletAddress.addressBytes;

      // Act
      bool actualSignatureValid = SignatureUtils.verifySignature(
        addressBytes: addressBytes,
        signatureDataHashBytes: queryAccountResponseSignHashBytes,
        signatureModel: signatureModel,
      );

      // Assert
      expect(actualSignatureValid, false);
    });
  });
}
