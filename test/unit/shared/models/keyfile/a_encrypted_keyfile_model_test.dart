import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';
import 'package:miro/shared/entity/keyfile/ethereum_keyfile_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted/cosmos_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/decrypted/ethereum_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/cosmos_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/ethereum_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/keyfile/a_encrypted_keyfile_model_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
  String actualCosmosPassword = '123';
  String actualEthereumPassword = 'yourpassword';

  group('Tests of AEncryptedKeyfileModel.fromEntity() factory constructor', () {
    test('Should [return CosmosEncryptedKeyfileModel] with version 2.0.0', () {
      // Arrange
      Map<String, dynamic> actualKeyfileContent = <String, dynamic>{
        'public_key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        'version': '2.0.0',
        'secret_data':
            'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg='
      };

      // Act
      AKeyfileEntity actualKeyfileEntity = AKeyfileEntity.fromJson(actualKeyfileContent);
      CosmosEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(actualKeyfileEntity) as CosmosEncryptedKeyfileModel;

      // Assert
      CosmosEncryptedKeyfileModel expectedEncryptedKeyfileModel = CosmosEncryptedKeyfileModel(
        version: '2.0.0',
        publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
        encryptedSecretData:
            'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
      );

      expect(actualEncryptedKeyfileModel, expectedEncryptedKeyfileModel);
    });

    test('Should [return EthereumEncryptedKeyfileModel]', () {
      // Arrange
      Map<String, dynamic> actualKeyfileContent = jsonDecode('''
        {
          "version": 3,
          "id": "2b27a028-6d11-4cf4-9ca0-525ac3a74bd2",
          "crypto": {
            "ciphertext": "68ccb4e87bf5b8f6e2491d568f3693507bf44fe5cad9f1f8de5c95dc657d5c13",
            "cipherparams": {
              "iv": "4df5d2e2ce0d941cce854e0c160e0004"
            },
            "cipher": "aes-128-ctr",
            "kdf": "pbkdf2",
            "kdfparams": {
              "dklen": 32,
              "salt": "cb757d6c1214dc08f61b145696b518a105e928bbe9139a2af45901947f5f49cc",
              "c": 262144,
              "prf": "hmac-sha256"
            },
            "mac": "cb666fcfb66a9b012c95723b3f88ce3d5ebbb6a151e901fd7ebdc85bc92abb3a"
          }
        }
        ''') as Map<String, dynamic>;

      // Act
      AKeyfileEntity actualKeyfileEntity = AKeyfileEntity.fromJson(actualKeyfileContent);
      EthereumEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(actualKeyfileEntity) as EthereumEncryptedKeyfileModel;

      // Assert
      EthereumEncryptedKeyfileModel expectedEncryptedKeyfileModel = const EthereumEncryptedKeyfileModel(
        ethereumKeyfileEntity: EthereumKeyfileEntity(
          version: 3,
          id: '2b27a028-6d11-4cf4-9ca0-525ac3a74bd2',
          crypto: EthereumKeyfileCrypto(
            ciphertext: '68ccb4e87bf5b8f6e2491d568f3693507bf44fe5cad9f1f8de5c95dc657d5c13',
            cipherparams: EthereumKeyfileCipherParams(iv: '4df5d2e2ce0d941cce854e0c160e0004'),
            cipher: 'aes-128-ctr',
            kdf: 'pbkdf2',
            kdfparams: EthereumKeyfileKdfParams(
              dklen: 32,
              salt: 'cb757d6c1214dc08f61b145696b518a105e928bbe9139a2af45901947f5f49cc',
              c: 262144,
              prf: 'hmac-sha256',
            ),
            mac: 'cb666fcfb66a9b012c95723b3f88ce3d5ebbb6a151e901fd7ebdc85bc92abb3a',
          ),
        ),
      );

      expect(actualEncryptedKeyfileModel, expectedEncryptedKeyfileModel);
    });

    test('Should [throw KeyfileException] with [KeyfileExceptionType.invalidKeyfile] if keyfile is invalid', () {
      // Act
      Object? actualException = TestUtils.catchException(() => AKeyfileEntity.fromJson(const <String, dynamic>{'invalid_key': 'invalid_value'}));

      // Assert
      KeyfileException expectedException = const KeyfileException(KeyfileExceptionType.invalidKeyfile);

      expect(actualException, expectedException);
    });
  });

  group('Tests of AEncryptedKeyfileModel.decrypt() method', () {
    test('Should [return CosmosDecryptedKeyfileModel] with version 2.0.0', () async {
      // Arrange
      CosmosEncryptedKeyfileModel actualEncryptedKeyfileModel = CosmosEncryptedKeyfileModel(
        version: '2.0.0',
        publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
        encryptedSecretData:
            'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
      );

      // Act
      CosmosDecryptedKeyfileModel actualDecryptedKeyfileModel = await actualEncryptedKeyfileModel.decrypt(actualCosmosPassword);

      // Assert
      CosmosDecryptedKeyfileModel expectedDecryptedKeyfileModel = CosmosDecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.kiraWallet),
      );

      expect(actualDecryptedKeyfileModel, expectedDecryptedKeyfileModel);
    });

    test('Should [return EthereumDecryptedKeyfileModel]', () async {
      // Arrange
      EthereumEncryptedKeyfileModel actualEncryptedKeyfileModel = const EthereumEncryptedKeyfileModel(
        ethereumKeyfileEntity: EthereumKeyfileEntity(
          version: 3,
          id: '2b27a028-6d11-4cf4-9ca0-525ac3a74bd2',
          crypto: EthereumKeyfileCrypto(
            ciphertext: '68ccb4e87bf5b8f6e2491d568f3693507bf44fe5cad9f1f8de5c95dc657d5c13',
            cipherparams: EthereumKeyfileCipherParams(iv: '4df5d2e2ce0d941cce854e0c160e0004'),
            cipher: 'aes-128-ctr',
            kdf: 'pbkdf2',
            kdfparams: EthereumKeyfileKdfParams(
              dklen: 32,
              salt: 'cb757d6c1214dc08f61b145696b518a105e928bbe9139a2af45901947f5f49cc',
              c: 262144,
              prf: 'hmac-sha256',
            ),
            mac: 'cb666fcfb66a9b012c95723b3f88ce3d5ebbb6a151e901fd7ebdc85bc92abb3a',
          ),
        ),
      );

      // Act
      EthereumDecryptedKeyfileModel actualDecryptedKeyfileModel = await actualEncryptedKeyfileModel.decrypt(actualEthereumPassword);

      // Assert
      EthereumDecryptedKeyfileModel expectedDecryptedKeyfileModel = EthereumDecryptedKeyfileModel(
        keyfileSecretDataModel:
            KeyfileSecretDataModel(wallet: Wallet.fromEthereumPrivateKey('2dfa536266295b697de5226f9bdf088118e5dc24efb448ee8d77a25eff225955')),
      );

      expect(actualDecryptedKeyfileModel, expectedDecryptedKeyfileModel);
    });

    group('Wrong password', () {
      test('Cosmos: Should [throw KeyfileException] with [KeyfileExceptionType.wrongPassword] if password is invalid', () async {
        // Arrange
        CosmosEncryptedKeyfileModel actualEncryptedKeyfileModel = CosmosEncryptedKeyfileModel(
          version: '2.0.0',
          publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
          encryptedSecretData:
              'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
        );

        // Act
        Object? actualException = await TestUtils.catchAsyncException(() async => actualEncryptedKeyfileModel.decrypt('invalid_password'));

        // Assert
        KeyfileException expectedException = const KeyfileException(KeyfileExceptionType.wrongPassword);

        expect(actualException, expectedException);
      });

      test('Ethereum - wrong password: Should [throw KeyfileException] with [KeyfileExceptionType.wrongPassword]', () async {
        // Arrange
        EthereumEncryptedKeyfileModel actualEncryptedKeyfileModel = const EthereumEncryptedKeyfileModel(
          ethereumKeyfileEntity: EthereumKeyfileEntity(
            version: 3,
            id: '2b27a028-6d11-4cf4-9ca0-525ac3a74bd2',
            crypto: EthereumKeyfileCrypto(
              ciphertext: '68ccb4e87bf5b8f6e2491d568f3693507bf44fe5cad9f1f8de5c95dc657d5c13',
              cipherparams: EthereumKeyfileCipherParams(iv: '4df5d2e2ce0d941cce854e0c160e0004'),
              cipher: 'aes-128-ctr',
              kdf: 'pbkdf2',
              kdfparams: EthereumKeyfileKdfParams(
                dklen: 32,
                salt: 'cb757d6c1214dc08f61b145696b518a105e928bbe9139a2af45901947f5f49cc',
                c: 262144,
                prf: 'hmac-sha256',
              ),
              mac: 'cb666fcfb66a9b012c95723b3f88ce3d5ebbb6a151e901fd7ebdc85bc92abb3a',
            ),
          ),
        );

        // Act
        Object? actualException = await TestUtils.catchAsyncException(() async => actualEncryptedKeyfileModel.decrypt('invalid_password'));

        // Assert
        KeyfileException expectedException = const KeyfileException(KeyfileExceptionType.wrongPassword);

        expect(actualException, expectedException);
      });

      test('Ethereum - wrong mac: Should [throw KeyfileException] with [KeyfileExceptionType.wrongPassword]', () async {
        // Arrange
        EthereumEncryptedKeyfileModel actualEncryptedKeyfileModel = const EthereumEncryptedKeyfileModel(
          ethereumKeyfileEntity: EthereumKeyfileEntity(
            version: 3,
            id: '2b27a028-6d11-4cf4-9ca0-525ac3a74bd2',
            crypto: EthereumKeyfileCrypto(
              ciphertext: '68ccb4e87bf5b8f6e2491d568f3693507bf44fe5cad9f1f8de5c95dc657d5c13',
              cipherparams: EthereumKeyfileCipherParams(iv: '4df5d2e2ce0d941cce854e0c160e0004'),
              cipher: 'aes-128-ctr',
              kdf: 'pbkdf2',
              kdfparams: EthereumKeyfileKdfParams(
                dklen: 32,
                salt: 'cb757d6c1214dc08f61b145696b518a105e928bbe9139a2af45901947f5f49cc',
                c: 262144,
                prf: 'hmac-sha256',
              ),
              mac: '11111fcfb66a9b012c95723b3f88ce3d5ebbb6a151e901fd7ebdc85bc92abb3a',
            ),
          ),
        );

        // Act
        Object? actualException = await TestUtils.catchAsyncException(() async => actualEncryptedKeyfileModel.decrypt(actualEthereumPassword));

        // Assert
        KeyfileException expectedException = const KeyfileException(KeyfileExceptionType.wrongPassword);

        expect(actualException, expectedException);
      });
    });
  });
}
