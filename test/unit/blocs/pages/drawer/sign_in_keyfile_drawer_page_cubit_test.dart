import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_state.dart';
import 'package:miro/blocs/widgets/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/mnemonic/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/sign_in_keyfile_drawer_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  FileModel actualValidFileModel = const FileModel(
    size: 537,
    name: 'keyfile_kira143q_k9wx',
    extension: 'json',
    content:
        '{"version": "2.0.0", "public_key": "AlLas8CJ6lm5yZJ8h0U5Qu9nzVvgvskgHuURPB3jvUx8", "secret_data": "RDjZC9U7JTFrsk3u9D7jDf17Ih1IerFTga6ayTR3Ig6Ay5vaRtHAhm/rnmuIQBUDeyXvffcpElfsZwh4LvOwwzzLd9pzRq5CLk3LBqAT6zC/aPsNimo5uXEESeIfua5oUBbob6eyO4bMMLh2NMUhoo/2CIg="}',
  );

  FileModel actualInvalidFileModel = const FileModel(
    size: 537,
    name: 'invalid_keyfile_kira143q_k9wx',
    extension: 'exe',
    content: 'invalid_content',
  );

  group('Tests of [SignInKeyfileDrawerPageCubit] process', () {
    // Arrange
    KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();
    TextEditingController actualPasswordTextEditingController = TextEditingController();
    SignInKeyfileDrawerPageCubit actualSignInKeyfileDrawerPageCubit = SignInKeyfileDrawerPageCubit(
      keyfileDropzoneCubit: actualKeyfileDropzoneCubit,
      passwordTextEditingController: actualPasswordTextEditingController,
    );

    test('Should return empty [SignInKeyfileDrawerPageState] as a default [SignInKeyfileDrawerPageState]', () async {
      // Assert
      SignInKeyfileDrawerPageState expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState();

      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);
    });

    test('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.invalidKeyfile] if keyfile is invalid', () async {
      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(actualInvalidFileModel);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      SignInKeyfileDrawerPageState expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.invalidKeyfile,
        decryptedKeyfileModel: null,
      );

      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);
    });

    test('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.wrongPassword] if keyfile is valid but password is not provided', () async {
      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(actualValidFileModel);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      SignInKeyfileDrawerPageState expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.wrongPassword,
        decryptedKeyfileModel: null,
      );

      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);
    });

    test('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.wrongPassword] if provided password is invalid', () async {
      // Act
      actualPasswordTextEditingController.text = '123456';
      actualSignInKeyfileDrawerPageCubit.notifyPasswordChanged();

      // Assert
      SignInKeyfileDrawerPageState expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.wrongPassword,
        decryptedKeyfileModel: null,
      );

      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);
    });

    test('Should return [SignInKeyfileDrawerPageState] with decrypted keyfile after enter valid password', () async {
      // Act
      actualPasswordTextEditingController.text = '123';
      actualSignInKeyfileDrawerPageCubit.notifyPasswordChanged();

      // Assert
      SignInKeyfileDrawerPageState expectedSignInKeyfileDrawerPageState = SignInKeyfileDrawerPageState(
        decryptedKeyfileModel: DecryptedKeyfileModel(
          version: '2.0.0',
          keyfileSecretDataModel: KeyfileSecretDataModel(
            wallet: await Wallet.derive(
              mnemonic: Mnemonic(
                value:
                    'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield',
              ),
            ),
          ),
        ),
      );

      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);
    });
  });
}
