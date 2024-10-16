import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/shared/entity/keyfile/ethereum_keyfile_entity.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/cosmos_encrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/encrypted/ethereum_encrypted_keyfile_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/kira/kira_dropzone/keyfile_dropzone_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  test('Init state', () {
    // Arrange
    KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();

    // Assert
    KeyfileDropzoneState expectedKeyfileDropzoneState = KeyfileDropzoneState.empty();

    TestUtils.printInfo('Should return [KeyfileDropzoneState.empty] as a default [KeyfileDropzoneState]');
    expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);
  });

  group('Tests of KeyfileDropzoneCubit.updateSelectedFile()', () {
    test('Cosmos keyfile', () {
      // Arrange
      KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();
      FileModel fileModel = const FileModel(
        size: 537,
        name: 'keyfile_kira143q_k9wx',
        extension: 'json',
        content:
            '{"version": "2.0.0", "public_key": "AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8", "secret_data": "RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg="}',
      );

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(fileModel);

      // Assert
      KeyfileDropzoneState expectedKeyfileDropzoneState = KeyfileDropzoneState(
        encryptedKeyfileModel: CosmosEncryptedKeyfileModel(
          version: '2.0.0',
          publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
          encryptedSecretData:
              'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
        ),
        fileModel: fileModel,
      );

      TestUtils.printInfo('Should return [KeyfileDropzoneState] with uploaded keyfile');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);
    });

    test('Ethereum keyfile', () {
      // Arrange
      KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();
      FileModel fileModel = const FileModel(
        size: 537,
        name: 'keyfile_0xb83DF7_E7b5',
        extension: 'json',
        content: '''
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
        ''',
      );

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(fileModel);

      // Assert
      KeyfileDropzoneState expectedKeyfileDropzoneState = KeyfileDropzoneState(
        encryptedKeyfileModel: const EthereumEncryptedKeyfileModel(
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
        ),
        fileModel: fileModel,
      );

      TestUtils.printInfo('Should return [KeyfileDropzoneState] with uploaded keyfile');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);
    });

    test('Invalid keyfile', () {
      // Arrange
      KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();
      FileModel fileModel = const FileModel(size: 537, name: 'holiday_photo', extension: 'jpg', content: 'sea');

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(fileModel);

      // Assert
      KeyfileDropzoneState expectedKeyfileDropzoneState = KeyfileDropzoneState(
        fileModel: fileModel,
        keyfileExceptionType: KeyfileExceptionType.invalidKeyfile,
      );

      TestUtils.printInfo('Should return [KeyfileDropzoneState] with uploaded file and Keyfile error if uploaded file is not a keyfile');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);
    });
  });
}
