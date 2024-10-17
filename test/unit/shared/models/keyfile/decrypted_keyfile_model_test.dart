import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/keyfile/decrypted_keyfile_model_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
  String actualPassword = '123';

  group('Tests of ADecryptedKeyfileModel.buildFileContent() method', () {
    test('Should [return ADecryptedKeyfileModel] representing keyfile in latest version [v2.0.0]', () {
      // Arrange
      ADecryptedKeyfileModel actualDecryptedKeyfileModel = ADecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.wallet),
      );

      // Act
      // Because of the random salt, we can't compare the whole keyfile content.
      // So basing on generated keyfile, we can parse it back to [ADecryptedKeyfileModel] and compare result
      String actualKeyfileContent = actualDecryptedKeyfileModel.buildFileContent(actualPassword);
      AKeyfileEntity actualKeyfileEntity = AKeyfileEntity.fromJson(jsonDecode(actualKeyfileContent) as Map<String, dynamic>);
      AEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(actualKeyfileEntity);
      actualDecryptedKeyfileModel = actualEncryptedKeyfileModel.decrypt(actualPassword);

      // Assert
      ADecryptedKeyfileModel expectedDecryptedKeyfileModel = ADecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.wallet),
      );

      expect(actualDecryptedKeyfileModel, expectedDecryptedKeyfileModel);
    });
  });

  group('Tests of ADecryptedKeyfileModel.fileName getter', () {
    test('Should return proper file name', () {
      // Arrange
      ADecryptedKeyfileModel decryptedKeyfileModel = ADecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.wallet),
      );

      // Act
      String actualFileName = decryptedKeyfileModel.fileName;

      // Assert
      String expectedFileName = 'keyfile_kira143q_k9wx.json';

      expect(actualFileName, expectedFileName);
    });
  });
}
