import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_cubit.dart';
import 'package:miro/blocs/pages/drawer/sign_in_drawer_page/sign_in_drawer_page_state.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/pages/drawer/sign_in_drawer_page_cubit_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final NetworkUnhealthyModel customNetworkUnhealthyModel = NetworkUnhealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://custom-unhealthy.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: 'v0.7.0.4',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
      activeValidators: 319,
      totalValidators: 475,
    ),
    tokenDefaultDenomModel: TokenDefaultDenomModel.empty(),
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.missingDefaultTokenDenomModel,
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
    lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
  );

  group('Tests of [SignInDrawerPageCubit] process', () {
    test('Should return SignInDrawerPageState consistent with network response', () async {
      // Arrange
      globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(customNetworkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      SignInDrawerPageCubit actualSignInDrawerPageCubit = SignInDrawerPageCubit();

      // Act
      SignInDrawerPageState actualSignInDrawerPageState = actualSignInDrawerPageCubit.state;
      bool actualDisabledBool = actualSignInDrawerPageState.disabledBool;

      // Assert
      TestUtils.printInfo('Should emit SignInDrawerPageState with [disabledBool] TRUE as initial state');
      expect(actualDisabledBool, true);

      // ************************************************************************************************

      // Act
      globalLocator<NetworkModuleBloc>().add(NetworkModuleConnectEvent(customNetworkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualSignInDrawerPageState = actualSignInDrawerPageCubit.state;
      actualDisabledBool = actualSignInDrawerPageState.disabledBool;

      // Assert
      TestUtils.printInfo('Should emit SignInDrawerPageState with [disabledBool] TRUE after connecting to unhealthy network (TokenDefaultDenomModel = null)');
      expect(actualDisabledBool, true);

      // ************************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://healthy.kira.network/'));
      actualSignInDrawerPageState = actualSignInDrawerPageCubit.state;
      actualDisabledBool = actualSignInDrawerPageState.disabledBool;

      // Assert
      TestUtils.printInfo('Should emit SignInDrawerPageState with [disabledBool] FALSE after connecting to healthy network');
      expect(actualDisabledBool, false);

      // ************************************************************************************************

      // Act
      await TestUtils.setupNetworkModel(networkUri: Uri.parse('https://offline.kira.network/'));
      actualSignInDrawerPageState = actualSignInDrawerPageCubit.state;
      actualDisabledBool = actualSignInDrawerPageState.disabledBool;

      // Assert
      TestUtils.printInfo('Should emit SignInDrawerPageState with [disabledBool] FALSE after losing connection');
      expect(actualDisabledBool, false);
    });
  });

  group('Tests of [SignInDrawerPageCubit] response to network refreshing', () {
    test('Should emit SignInDrawerPageState with [refreshUnlockingDateTime] 60 SEC FROM NOW after network refresh', () async {
      // Arrange
      SignInDrawerPageCubit actualSignInDrawerPageCubit = SignInDrawerPageCubit()..refreshNetwork();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      SignInDrawerPageState actualSignInDrawerPageState = actualSignInDrawerPageCubit.state;
      DateTime actualRefreshUnlockingDateTime = actualSignInDrawerPageState.refreshUnlockingDateTime!;
      int actualSecondsUntilUnlock = actualRefreshUnlockingDateTime.difference(DateTime.now()).inSeconds;

      // Assert
      // Expecting 59 seconds because DateTime.inSeconds method rounds the value down (59.9s -> 59.0s)
      int expectedSecondsUntilUnlock = 59;
      expect(actualSecondsUntilUnlock, expectedSecondsUntilUnlock);
    });

    test('Should emit SignInDrawerPageState with [refreshUnlockingDateTime] 57 SEC FROM NOW if network refresh was 3 seconds ago', () async {
      // Arrange
      await Future<void>.delayed(const Duration(milliseconds: 3000));
      SignInDrawerPageCubit actualSignInDrawerPageCubit = SignInDrawerPageCubit();
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Act
      SignInDrawerPageState actualSignInDrawerPageState = actualSignInDrawerPageCubit.state;
      DateTime actualRefreshUnlockingDateTime = actualSignInDrawerPageState.refreshUnlockingDateTime!;
      int actualSecondsUntilUnlock = actualRefreshUnlockingDateTime.difference(DateTime.now()).inSeconds;

      // Assert
      // Expecting 56 seconds because DateTime.inSeconds method rounds the value down (56.9s -> 56.0s)
      int expectedSecondsUntilUnlock = 56;
      expect(actualSecondsUntilUnlock, expectedSecondsUntilUnlock);
    });
  });
}
