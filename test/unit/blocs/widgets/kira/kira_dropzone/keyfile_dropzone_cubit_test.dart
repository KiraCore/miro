import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/kira/kira_dropzone/keyfile_dropzone_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  group('Tests of KeyfileDropzoneCubit.updateSelectedFile()', () {
    test('Should return [KeyfileDropzoneState]', () {
      // Arrange
      KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();

      // Assert
      KeyfileDropzoneState expectedKeyfileDropzoneState = KeyfileDropzoneState.empty();

      TestUtils.printInfo('Should return [KeyfileDropzoneState.empty] as a default [KeyfileDropzoneState]');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);

      // ****************************************************************************************

      // Arrange
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
      expectedKeyfileDropzoneState = KeyfileDropzoneState(
        encryptedKeyfileModel: EncryptedKeyfileModel(
          version: '2.0.0',
          publicKey: base64Decode('AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8'),
          encryptedSecretData:
              'RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg=',
        ),
        fileModel: fileModel,
      );

      TestUtils.printInfo('Should return [KeyfileDropzoneState] with uploaded keyfile');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);

      // ****************************************************************************************

      // Arrange
      fileModel = const FileModel(size: 537, name: 'holiday_photo', extension: 'jpg', content: 'sea');

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(fileModel);

      // Assert
      expectedKeyfileDropzoneState = KeyfileDropzoneState(
        fileModel: fileModel,
        keyfileExceptionType: KeyfileExceptionType.invalidKeyfile,
      );

      TestUtils.printInfo('Should return [KeyfileDropzoneState] with uploaded file and Keyfile error if uploaded file is not a keyfile');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);
    });
  });
}
