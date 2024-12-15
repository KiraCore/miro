import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';
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
// fvm flutter test test/unit/shared/models/keyfile/a_decrypted_keyfile_model_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of ADecryptedKeyfileModel.buildFileContent() method', () {
    test('Should [return CosmosDecryptedKeyfileModel] representing keyfile in latest version [v2.0.0]', () async {
      // Arrange
      CosmosDecryptedKeyfileModel actualDecryptedKeyfileModel = CosmosDecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.kiraWallet),
      );
      String actualPassword = '123';

      // Act
      // Because of the random salt, we can't compare the whole keyfile content.
      // So basing on generated keyfile, we can parse it back to [CosmosDecryptedKeyfileModel] and compare result
      String actualKeyfileContent = await actualDecryptedKeyfileModel.buildFileContent(actualPassword);
      AKeyfileEntity actualKeyfileEntity = AKeyfileEntity.fromJson(jsonDecode(actualKeyfileContent) as Map<String, dynamic>);
      CosmosEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(actualKeyfileEntity) as CosmosEncryptedKeyfileModel;
      actualDecryptedKeyfileModel = await actualEncryptedKeyfileModel.decrypt(actualPassword);

      // Assert
      CosmosDecryptedKeyfileModel expectedDecryptedKeyfileModel = CosmosDecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.kiraWallet),
      );

      expect(actualDecryptedKeyfileModel, expectedDecryptedKeyfileModel);
    });

    test('Should [return EthereumDecryptedKeyfileModel] representing keyfile', () async {
      // Arrange
      EthereumDecryptedKeyfileModel actualDecryptedKeyfileModel = EthereumDecryptedKeyfileModel(
        keyfileSecretDataModel:
            KeyfileSecretDataModel(wallet: Wallet.fromEthereumPrivateKey('2dfa536266295b697de5226f9bdf088118e5dc24efb448ee8d77a25eff225955')),
      );
      String actualPassword = 'yourpassword';

      // Act
      // Basing on generated keyfile, we are parsing it back to [EthereumEncryptedKeyfileModel] and compare result
      String actualKeyfileContent = await actualDecryptedKeyfileModel.buildFileContent(actualPassword);
      AKeyfileEntity actualKeyfileEntity = AKeyfileEntity.fromJson(jsonDecode(actualKeyfileContent) as Map<String, dynamic>);
      EthereumEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(actualKeyfileEntity) as EthereumEncryptedKeyfileModel;
      actualDecryptedKeyfileModel = await actualEncryptedKeyfileModel.decrypt(actualPassword);

      // Assert
      EthereumDecryptedKeyfileModel expectedDecryptedKeyfileModel = actualDecryptedKeyfileModel;

      expect(actualDecryptedKeyfileModel, expectedDecryptedKeyfileModel);
    });
  });

  group('Tests of ADecryptedKeyfileModel.fileName getter', () {
    test('Cosmos file name', () {
      // Arrange
      CosmosDecryptedKeyfileModel decryptedKeyfileModel = CosmosDecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.kiraWallet),
      );

      // Act
      String actualFileName = decryptedKeyfileModel.fileName;

      // Assert
      String expectedFileName = 'keyfile_kira143q_k9wx.json';

      expect(actualFileName, expectedFileName);
    });

    test('Ethereum file name', () {
      // Arrange
      EthereumDecryptedKeyfileModel decryptedKeyfileModel = EthereumDecryptedKeyfileModel(
        keyfileSecretDataModel:
            KeyfileSecretDataModel(wallet: Wallet.fromEthereumPrivateKey('2dfa536266295b697de5226f9bdf088118e5dc24efb448ee8d77a25eff225955')),
      );

      // Act
      String actualFileName = decryptedKeyfileModel.fileName;

      // Assert
      String expectedFileName = 'keyfile_0xb83DF7_E7b5.json';

      expect(actualFileName, expectedFileName);
    });
  });
}
