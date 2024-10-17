import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/shared/entity/keyfile/a_keyfile_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/keyfile/decrypted/a_decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/a_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/shared/models/keyfile/encrypted_keyfile_model_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
  String actualPassword = '123';

  group('Tests of AEncryptedKeyfileModel.fromEntity() factory constructor', () {
    test('Should [return AEncryptedKeyfileModel] with version 2.0.0', () {
      // Arrange
      // @formatter:off
      Map<String, dynamic> actualKeyfileContent = <String, dynamic>{
        'public_key': 'AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8',
        'version': '2.0.0',
        'secret_data': 'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg='
      };
      // @formatter:on

      // Act
      AKeyfileEntity actualKeyfileEntity = AKeyfileEntity.fromJson(actualKeyfileContent);
      AEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel.fromEntity(actualKeyfileEntity);

      // Assert
      // @formatter:off
      AEncryptedKeyfileModel expectedEncryptedKeyfileModel = AEncryptedKeyfileModel(
        version: '2.0.0',
        publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
        encryptedSecretData: 'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
      );
      // @formatter:on

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
    test('Should [return ADecryptedKeyfileModel] with version 2.0.0', () {
      // Arrange
      // @formatter:off
      AEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel(
        version: '2.0.0',
        publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
        encryptedSecretData: 'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
      );
      // @formatter:on

      // Act
      ADecryptedKeyfileModel actualDecryptedKeyfileModel = actualEncryptedKeyfileModel.decrypt(actualPassword);

      // Assert
      ADecryptedKeyfileModel expectedDecryptedKeyfileModel = ADecryptedKeyfileModel(
        version: '2.0.0',
        keyfileSecretDataModel: KeyfileSecretDataModel(wallet: TestUtils.wallet),
      );

      expect(actualDecryptedKeyfileModel, expectedDecryptedKeyfileModel);
    });

    test('Should [throw KeyfileException] with [KeyfileExceptionType.wrongPassword] if password is invalid', () {
      // Arrange
      // @formatter:off
      AEncryptedKeyfileModel actualEncryptedKeyfileModel = AEncryptedKeyfileModel(
        version: '2.0.0',
        publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
        encryptedSecretData: 'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
      );
      // @formatter:on

      // Act
      Object? actualException = TestUtils.catchException(() => actualEncryptedKeyfileModel.decrypt('invalid_password'));

      // Assert
      KeyfileException expectedException = const KeyfileException(KeyfileExceptionType.wrongPassword);

      expect(actualException, expectedException);
    });
  });
}