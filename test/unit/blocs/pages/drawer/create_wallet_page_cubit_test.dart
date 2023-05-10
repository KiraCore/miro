import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/a_create_wallet_page_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/create_wallet_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/states/create_wallet_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_page/states/create_wallet_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/create_wallet_page_cubit_test.dart --platform chrome --null-assertions
void main() {
  initMockLocator();

  group('Tests of [CreateWalletPageCubit] process', () {
    test('Should return [ACreateWalletPageState] consistent with current action', () async {
      // Arrange
      AuthCubit actualAuthCubit = globalLocator<AuthCubit>();
      CreateWalletPageCubit actualCreateWalletPageCubit = CreateWalletPageCubit();

      // Act
      ACreateWalletPageState actualCreateWalletPageState = actualCreateWalletPageCubit.state;

      // Assert
      ACreateWalletPageState expectedCreateWalletPageState = CreateWalletPageLoadingState();

      TestUtils.printInfo('Should return [CreateWalletPageLoadingState] as initial [CreateWalletPageCubit] state');
      expect(actualCreateWalletPageState, expectedCreateWalletPageState);

      // ****************************************************************************************

      // Assert
      TestUtils.printInfo('Should throw Exception if wallet is not created, but signIn() method is called');
      expect(
        () => actualCreateWalletPageCubit.signIn(),
        throwsA(isA<Exception>()),
      );

      // ****************************************************************************************

      // Act
      await actualCreateWalletPageCubit.generateNewAddress();
      bool actualCreateWalletPageLoadedBool = actualCreateWalletPageCubit.state is CreateWalletPageLoadedState;

      // Assert
      // Because of the output of the method [CreateWalletPageCubit.generateNewAddress()] is always random
      // we can't compare the output with the expected value. Instead, we compare the type of emitted state

      TestUtils.printInfo('Should return [CreateWalletPageLoadedState] with created wallet');
      expect(actualCreateWalletPageLoadedBool, true);

      // ****************************************************************************************

      // Act
      actualCreateWalletPageCubit.signIn();

      // Assert
      TestUtils.printInfo('Should login into application after calling signIn() method');
      expect(actualAuthCubit.isSignedIn, true);
    });
  });
}
