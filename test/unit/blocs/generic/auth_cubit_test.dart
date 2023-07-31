import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/auth_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  group('Tests of [AuthCubit] process', () {
    test('Should return states assigned to specific actions', () async {
      // Arrange
      final AuthCubit actualAuthCubit = AuthCubit();

      // Assert
      Wallet? expectedWallet;

      TestUtils.printInfo('Should return [null] as initial state of [AuthCubit]');
      expect(actualAuthCubit.state, expectedWallet);

      // ************************************************************************************************

      // Act
      await actualAuthCubit.signIn(TestUtils.wallet);

      // Assert
      expectedWallet = TestUtils.wallet;

      TestUtils.printInfo('Should return [Wallet] after sign in');
      expect(actualAuthCubit.state, expectedWallet);

      // ************************************************************************************************

      // Act
      await actualAuthCubit.signOut();

      // Assert
      expectedWallet = null;

      TestUtils.printInfo('Should return [null] after sign out');
      expect(actualAuthCubit.state, expectedWallet);
    });
  });
}
