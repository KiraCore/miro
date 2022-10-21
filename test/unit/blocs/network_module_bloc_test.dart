import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_init_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_refresh_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/shared/controllers/browser/rpc_browser_url_controller.dart';
import 'package:miro/shared/models/network/data/connection_status_type.dart';
import 'package:miro/shared/models/network/data/interx_warning_model.dart';
import 'package:miro/shared/models/network/data/interx_warning_type.dart';
import 'package:miro/shared/models/network/data/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_offline_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_module_bloc_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  RpcBrowserUrlController rpcBrowserUrlController = RpcBrowserUrlController();
  NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
  );

  NetworkUnknownModel healthyNetworkUnknownModel = NetworkUnknownModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
  );

  NetworkUnhealthyModel networkUnhealthyModel = NetworkUnhealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://unhealthy.kira.network'),
    name: 'unhealthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: 'v0.7.0.4',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
    ),
    interxWarningModel: const InterxWarningModel(<InterxWarningType>[
      InterxWarningType.versionOutdated,
      InterxWarningType.blockTimeOutdated,
    ]),
  );

  NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    connectionStatusType: ConnectionStatusType.disconnected,
    uri: Uri.parse('https://healthy.kira.network'),
    name: 'healthy-mainnet',
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      interxVersion: 'v0.4.20-rc2',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
      activeValidators: 319,
      totalValidators: 475,
    ),
  );

  group('Tests of network connection process', () {
    test('Should connect to default network, because it`s healthy network', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      rpcBrowserUrlController.setRpcAddress(healthyNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState =
          NetworkModuleState.connecting(healthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected));

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
      expectedNetworkModuleState = NetworkModuleState.connecting(networkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkUnhealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state) if default network is unhealthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleConnectEvent(networkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkUnhealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnhealthyModel (connected state) after select network');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);
    });

    test('Should allow to change connected network', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      rpcBrowserUrlController.setRpcAddress(healthyNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connecting(healthyNetworkUnknownModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if default network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleConnectEvent(networkUnhealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkUnhealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnhealthyModel (connected state) if network is unhealthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleConnectEvent(networkHealthyModel));
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState = NetworkModuleState.connected(networkHealthyModel);

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);
    });

    test('Should allow to cancel connection while connecting in progress', () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      rpcBrowserUrlController.setRpcAddress(healthyNetworkUnknownModel);

      // Assert
      NetworkModuleState expectedNetworkModuleState = NetworkModuleState.disconnected();

      TestUtils.printInfo('Should return NetworkModuleState with NetworkEmptyModel (disconnected state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleInitEvent());
      await Future<void>.delayed(const Duration(milliseconds: 40));

      // Assert
      expectedNetworkModuleState =
          NetworkModuleState.connecting(healthyNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting));

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

  group('Tests of network refreshing process', () {
    test('Should refresh network list. First state should contain NetworkHealthyModel, next NetworkUnhealthyModel and last NetworkOfflineModel',
        () async {
      // Arrange
      NetworkModuleBloc actualNetworkBloc = NetworkModuleBloc();
      NetworkUnknownModel dynamicNetworkUnknownModel = NetworkUnknownModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://dynamic.kira.network'),
      );
      NetworkHealthyModel dynamicNetworkHealthyModel = NetworkHealthyModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://dynamic.kira.network'),
        networkInfoModel: NetworkInfoModel(
          chainId: 'localnet-1',
          interxVersion: 'v0.4.20-rc2',
          latestBlockHeight: 108843,
          latestBlockTime: DateTime.now(),
        ),
      );
      NetworkUnhealthyModel dynamicNetworkUnhealthyModel = NetworkUnhealthyModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://dynamic.kira.network'),
        networkInfoModel: NetworkInfoModel(
          chainId: 'testnet-7',
          interxVersion: 'v0.7.0.4',
          latestBlockHeight: 108843,
          latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
        ),
        interxWarningModel: const InterxWarningModel(<InterxWarningType>[
          InterxWarningType.versionOutdated,
          InterxWarningType.blockTimeOutdated,
        ]),
      );
      NetworkOfflineModel dynamicNetworkOfflineModel = NetworkOfflineModel(
        connectionStatusType: ConnectionStatusType.disconnected,
        uri: Uri.parse('https://dynamic.kira.network'),
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
      expectedNetworkModuleState =
          NetworkModuleState.connecting(dynamicNetworkUnknownModel.copyWith(connectionStatusType: ConnectionStatusType.connecting));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkUnknownModel (connecting state)');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState =
          NetworkModuleState.connected(dynamicNetworkHealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected));

      TestUtils.printInfo('Should return NetworkModuleState with NetworkHealthyModel (connected state) if default network is healthy');
      expect(actualNetworkBloc.state, expectedNetworkModuleState);

      // Act
      actualNetworkBloc.add(NetworkModuleRefreshEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));

      // Assert
      expectedNetworkModuleState =
          NetworkModuleState.connected(dynamicNetworkUnhealthyModel.copyWith(connectionStatusType: ConnectionStatusType.connected));

      TestUtils.printInfo(
          'Should return NetworkModuleState with NetworkUnhealthyModel if current network changed status to unhealthy after refreshing');
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
