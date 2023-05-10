import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/auth/auth_cubit.dart';
import 'package:miro/shared/models/wallet/wallet.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/auth/auth_cubit_test.dart --platform chrome --null-assertions
void main() {
  group('Tests of [AuthCubit] process', () {
    test('Should return states assigned to specific actions ', () {
      // Arrange
      final AuthCubit actualAuthCubit = AuthCubit();

      // Assert
      Wallet? expectedWallet;

      TestUtils.printInfo('Should return [null] as initial state of [AuthCubit]');
      expect(actualAuthCubit.state, expectedWallet);

      // ************************************************************************************************

      // Act
      actualAuthCubit.signIn(TestUtils.wallet);

      // Assert
      expectedWallet = TestUtils.wallet;

      TestUtils.printInfo('Should return [Wallet] after sign in');
      expect(actualAuthCubit.state, expectedWallet);

      // ************************************************************************************************

      // Act
      actualAuthCubit.signOut();

      // Assert
      expectedWallet = null;

      TestUtils.printInfo('Should return [null] after sign out');
      expect(actualAuthCubit.state, expectedWallet);
    });
  });
}
