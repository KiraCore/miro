import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/generic/network_module/events/network_module_refresh_event.dart';
import 'package:miro/blocs/generic/network_module/network_module_bloc.dart';
import 'package:miro/blocs/generic/network_module/network_module_state.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/generic/network_module_bloc_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  RpcBrowserUrlController rpcBrowserUrlController = RpcBrowserUrlController();

  group('Tests of [NetworkModuleBloc] process: Network connection', () {
    test('Should connect to default network, because it`s healthy network', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      rpcBrowserUrlController.setRpcAddress(TestUtils.healthyNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState =
          NetworkModuleState.connecting(TestUtils.healthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if default network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      rpcBrowserUrlController.removeRpcAddress();
    });

    test(
        'Shouldn`t connect to default network, because it`s unhealthy network. Then connect to the same network without any errors using NetworkModuleConnectEvent',
        () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');

      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(
        TestUtils.unhealthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting),
      );

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkUnhealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state) if default network is unhealthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleConnectEvent(TestUtils.networkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkUnhealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnhealthyModel (connected state) after select network');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);
    });

    test('Should allow to change connected network', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      rpcBrowserUrlController.setRpcAddress(TestUtils.healthyNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(TestUtils.healthyNetworkUnknownModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if default network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleConnectEvent(TestUtils.networkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkUnhealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnhealthyModel (connected state) if network is unhealthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleConnectEvent(TestUtils.networkHealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(TestUtils.networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);
    });

    test('Should allow to cancel connection while connecting in progress', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      rpcBrowserUrlController.setRpcAddress(TestUtils.healthyNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(
        TestUtils.healthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting),
      );

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkEmptyModel if network connection was canceled');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);
    });
  });

  group('Tests of [NetworkModuleBloc] process: Network refreshing', () {
    test('Should refresh network list. First state should contain NetworkHealthyModel, next NetworkUnhealthyModel and last NetworkOfflineModel', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      NetworkUnknownModel dynamicNetworkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('http://dynamic.kira.network'),
        lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
        tokenDefaultDenomModel: TokenDefaultDenomModel.empty(),
      );

      NetworkHealthyModel dynamicNetworkHealthyModel = NetworkHealthyModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('http://dynamic.kira.network'),
        networkInfoModel: NetworkInfoModel(
          chainId: 'localnet-1',
          interxVersion: 'v0.4.22',
          latestBlockHeight: 108843,
          latestBlockTime: DateTime.now(),
        ),
        tokenDefaultDenomModel: TokenDefaultDenomModel(
          valuesFromNetworkExistBool: true,
          bech32AddressPrefix: 'kira',
          defaultTokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
      );

      NetworkUnhealthyModel dynamicNetworkUnhealthyModel = NetworkUnhealthyModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('http://dynamic.kira.network'),
        networkInfoModel: NetworkInfoModel(
          chainId: 'testnet-7',
          interxVersion: 'v0.7.0.4',
          latestBlockHeight: 108843,
          latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
        ),
        tokenDefaultDenomModel: TokenDefaultDenomModel(
          valuesFromNetworkExistBool: true,
          bech32AddressPrefix: 'kira',
          defaultTokenAliasModel: TestUtils.kexTokenAliasModel,
        ),
        interxWarningModel: const InterxWarningModel(<InterxWarningType>[
          InterxWarningType.versionOutdated,
          InterxWarningType.blockTimeOutdated,
        ]),
        lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
      );

      NetworkOfflineModel dynamicNetworkOfflineModel = NetworkOfflineModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('http://dynamic.kira.network'),
        lastRefreshDateTime: TestUtils.defaultLastRefreshDateTime,
        tokenDefaultDenomModel: TokenDefaultDenomModel.empty(),
      );

      rpcBrowserUrlController.setRpcAddress(dynamicNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(dynamicNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(dynamicNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if default network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleRefreshEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(dynamicNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnhealthyModel if current network changed status to unhealthy after refreshing');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleRefreshEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(dynamicNetworkOfflineModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel if current network changed status to offline after refreshing');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);
    });
  });
}
