import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/auth/auth_cubit.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/a_create_wallet_drawer_page_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/create_wallet_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/states/create_wallet_drawer_page_loaded_state.dart';
import 'package:miro/blocs/pages/drawer/create_wallet_drawer_page/states/create_wallet_drawer_page_loading_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/create_wallet_drawer_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));

  group('Tests of [CreateWalletDrawerPageCubit] process', () {
    test('Should return [ACreateWalletDrawerPageState] consistent with current action', () async {
      // Arrange
      AuthCubit actualAuthCubit = globalLocator<AuthCubit>();
      CreateWalletDrawerPageCubit actualCreateWalletDrawerPageCubit = CreateWalletDrawerPageCubit();

      // Act
      ACreateWalletDrawerPageState actualCreateWalletDrawerPageState = actualCreateWalletDrawerPageCubit.state;

      // Assert
      ACreateWalletDrawerPageState expectedCreateWalletDrawerPageState = CreateWalletDrawerPageLoadingState();

      TestUtils.printInfo('Should return [CreateWalletDrawerPageLoadingState] as initial [CreateWalletDrawerPageCubit] state');
      expect(actualCreateWalletDrawerPageState, expectedCreateWalletDrawerPageState);

      // ****************************************************************************************

      // Assert
      TestUtils.printInfo('Should throw Exception if wallet is not created, but signIn() method is called');
      expect(
        () => actualCreateWalletDrawerPageCubit.signIn(),
        throwsA(isA<Exception>()),
      );

      // ****************************************************************************************

      // Act
      await actualCreateWalletDrawerPageCubit.generateNewAddress();
      bool actualCreateWalletDrawerPageLoadedBool = actualCreateWalletDrawerPageCubit.state is CreateWalletDrawerPageLoadedState;

      // Assert
      // Because of the output of the method [CreateWalletDrawerPageCubit.generateNewAddress()] is always random
      // we can't compare the output with the expected value. Instead, we compare the type of emitted state

      TestUtils.printInfo('Should return [CreateWalletDrawerPageLoadedState] with created wallet');
      expect(actualCreateWalletDrawerPageLoadedBool, true);

      // ****************************************************************************************

      // Act
      actualCreateWalletDrawerPageCubit.signIn();

      // Assert
      TestUtils.printInfo('Should login into application after calling signIn() method');
      expect(actualAuthCubit.isSignedIn, true);
    });
  });
}
