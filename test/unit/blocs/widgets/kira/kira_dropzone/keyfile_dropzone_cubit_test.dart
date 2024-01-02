import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_state.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/encrypted_keyfile_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/widgets/kira/kira_dropzone/keyfile_dropzone_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  group('Tests of [KeyfileDropzoneCubit.updateSelectedFile]', () {
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
        content: '{"bech32_address": "kira17h42jhptp4r3gwwts33qju6y0nhn526kstzkv5","version": "1.1.0","secret_data": "XWmZ5zOCJauy09sG2KNKWQhpmDl+LLTLMkDeTTXxMFX/0TClsUh5fS8ppspyIY3R0haTcQqawC4tS38+6sBYoOp9Maet2uf4YKc6ez3YQz/AP7JM5ZQT71wimRTfmWkD5lL7VnZ7+TeO2cwhGNP6ql7vi+Y="}',
      );

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(fileModel);

      // Assert
      expectedKeyfileDropzoneState = KeyfileDropzoneState(
        encryptedKeyfileModel: EncryptedKeyfileModel(
          version: '1.1.0',
          walletAddress: WalletAddress.fromBech32('kira17h42jhptp4r3gwwts33qju6y0nhn526kstzkv5'),
          secretDataHash:
              'XWmZ5zOCJauy09sG2KNKWQhpmDl+LLTLMkDeTTXxMFX/0TClsUh5fS8ppspyIY3R0haTcQqawC4tS38+6sBYoOp9Maet2uf4YKc6ez3YQz/AP7JM5ZQT71wimRTfmWkD5lL7VnZ7+TeO2cwhGNP6ql7vi+Y=',
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

      // ****************************************************************************************

      // Arrange
      fileModel = const FileModel(size: 537, name: 'unsupported_keyfile', extension: 'json', content: '{"version":"100.200.300"}');

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(fileModel);

      // Assert
      expectedKeyfileDropzoneState = KeyfileDropzoneState(
        fileModel: fileModel,
        keyfileExceptionType: KeyfileExceptionType.unsupportedVersion,
      );

      TestUtils.printInfo('Should return [KeyfileDropzoneState] with uploaded file and Keyfile error if uploaded keyfile has unsupported version');
      expect(actualKeyfileDropzoneCubit.state, expectedKeyfileDropzoneState);
    });
  });
}
