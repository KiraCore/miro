import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_keyfile_drawer_page/sign_in_keyfile_drawer_page_state.dart';
import 'package:miro/blocs/widgets/kira/kira_dropzone/impl/keyfile_dropzone/keyfile_dropzone_cubit.dart';
import 'package:miro/shared/exceptions/keyfile_exception/keyfile_exception_type.dart';
import 'package:miro/shared/models/generic/file_model.dart';
import 'package:miro/shared/models/keyfile/decrypted_keyfile_model.dart';
import 'package:miro/shared/models/keyfile/keyfile_secret_data_model.dart';
import 'package:miro/shared/models/wallet/mnemonic.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/sign_in_keyfile_drawer_page_cubit_test.dart --platform chrome --null-assertions
void main() {
  initMockLocator();

  FileModel actualValidFileModel = const FileModel(
    size: 537,
    name: 'keyfile_kira143q_k9wx',
    extension: 'json',
    content:
        '{"bech32_address":"kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx","version": "1.1.0","secret_data": "2KgjBTl4Ufk4n/IjxQ9KuPf1LXHIm+JU8gkh+YimwGoeqmd/w86UjsrHbsFrQydqc+n53iozcGLFBC8Cf5EshyGyIvA6OaHzegqbmja210rd4t8T5V3QooHYJZ8v0NFe21Pnqzgzil9f2VUa1VUuXJlwCX4="}',
  );

  FileModel actualInvalidFileModel = const FileModel(
    size: 537,
    name: 'invalid_keyfile_kira143q_k9wx',
    extension: 'exe',
    content: 'invalid_content',
  );

  FileModel actualInvalidVersionFileModel = const FileModel(
    size: 537,
    name: 'keyfile_kira143q_k9wx',
    extension: 'json',
    content:
        '{"bech32_address":"kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx","version": "123.123.123","secret_data": "2KgjBTl4Ufk4n/IjxQ9KuPf1LXHIm+JU8gkh+YimwGoeqmd/w86UjsrHbsFrQydqc+n53iozcGLFBC8Cf5EshyGyIvA6OaHzegqbmja210rd4t8T5V3QooHYJZ8v0NFe21Pnqzgzil9f2VUa1VUuXJlwCX4="}',
  );

  group('Tests of [SignInKeyfileDrawerPageCubit]', () {
    test('Should emit [SignInKeyfileDrawerPageState]', () async {
      // Arrange
      KeyfileDropzoneCubit actualKeyfileDropzoneCubit = KeyfileDropzoneCubit();
      TextEditingController actualPasswordTextEditingController = TextEditingController();
      SignInKeyfileDrawerPageCubit actualSignInKeyfileDrawerPageCubit = SignInKeyfileDrawerPageCubit(
        keyfileDropzoneCubit: actualKeyfileDropzoneCubit,
        passwordTextEditingController: actualPasswordTextEditingController,
      );

      // Assert
      SignInKeyfileDrawerPageState expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState();

      TestUtils.printInfo('Should return empty [SignInKeyfileDrawerPageState] as a default [SignInKeyfileDrawerPageState]');
      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);

      // ****************************************************************************************

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(actualInvalidFileModel);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.invalidKeyfile,
        decryptedKeyfileModel: null,
      );

      TestUtils.printInfo('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.invalidKeyfile] if keyfile is invalid');
      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);

      // ****************************************************************************************

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(actualInvalidVersionFileModel);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.unsupportedVersion,
        decryptedKeyfileModel: null,
      );

      TestUtils.printInfo('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.unsupportedVersion] if keyfile version is not supported');
      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);

      // ****************************************************************************************

      // Act
      actualKeyfileDropzoneCubit.updateSelectedFile(actualValidFileModel);
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.wrongPassword,
        decryptedKeyfileModel: null,
      );

      TestUtils.printInfo('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.wrongPassword] if keyfile is valid but password is not provided');
      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);

      // ****************************************************************************************

      // Act
      actualPasswordTextEditingController.text = '123456';
      actualSignInKeyfileDrawerPageCubit.notifyPasswordChanged();

      // Assert
      expectedSignInKeyfileDrawerPageState = const SignInKeyfileDrawerPageState(
        keyfileExceptionType: KeyfileExceptionType.wrongPassword,
        decryptedKeyfileModel: null,
      );

      TestUtils.printInfo('Should return [SignInKeyfileDrawerPageState] with [KeyfileExceptionType.wrongPassword] if provided password is invalid');
      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);

      // ****************************************************************************************

      // Act
      actualPasswordTextEditingController.text = '123';
      actualSignInKeyfileDrawerPageCubit.notifyPasswordChanged();

      // Assert
      expectedSignInKeyfileDrawerPageState = SignInKeyfileDrawerPageState(
        decryptedKeyfileModel: DecryptedKeyfileModel(
          version: '1.1.0',
          keyfileSecretDataModel: KeyfileSecretDataModel(
            wallet: Wallet.derive(mnemonic: Mnemonic(value: 'require point property company tongue busy bench burden caution gadget knee glance thought bulk assist month cereal report quarter tool section often require shield')),
          ),
        ),
      );

      TestUtils.printInfo('Should return [SignInKeyfileDrawerPageState] with decrypted keyfile after enter valid password');
      expect(actualSignInKeyfileDrawerPageCubit.state, expectedSignInKeyfileDrawerPageState);
    });
  });
}