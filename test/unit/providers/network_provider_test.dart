import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_from_url_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network/states/network_connected_state.dart';
import 'package:miro/blocs/specific_blocs/network/states/network_disconnected_state.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/interx_error.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/providers/network_provider_test.dart --platform chrome
// ignore_for_file: cascade_invocations
Future<void> main() async {
  await initTestLocator();
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  String miroUri = 'https://miro.kira.network?rpc=https://online.kira.network';

  NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
    uri: Uri.parse('https://online.kira.network'),
  );

  NetworkUnhealthyModel networkUnhealthyModel = NetworkUnhealthyModel(
    uri: Uri.parse('https://online.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
    ),
    interxErrors: const <InterxError>[InterxError.versionOutdated],
  );

  group('Tests of network connecting process', () {
    test(
        'Should call NetworkConnectEvent and NetworkDisconnectEvent without errors, emit assigned AListState and modify NetworkProvider fields',
        () async {
      // Assign
      NetworkProvider actualNetworkProvider = NetworkProvider();

      // Assert
      testPrint('Should return NetworkDisconnectedState if network is not connected');
      expect(
        actualNetworkProvider.networkState,
        NetworkDisconnectedState(),
      );

      testPrint('Should return [networkStatusModel: null] if network is not connected');
      expect(
        actualNetworkProvider.networkStatusModel,
        null,
      );

      testPrint('Should return [networkUri: null] if network is not connected');
      expect(
        actualNetworkProvider.networkUri,
        null,
      );

      testPrint('Should return [isConnected: false] if network is not connected');
      expect(
        actualNetworkProvider.isConnected,
        false,
      );

      // Act
      await actualNetworkProvider.handleEvent(NetworkConnectEvent(networkUnknownModel));

      // Assert
      testPrint('Should return NetworkConnectedState if network is connected');
      expect(
        actualNetworkProvider.networkState,
        NetworkConnectedState(networkOnlineModel: networkUnhealthyModel),
      );

      testPrint('Should return [networkStatusModel: connectedNetworkStatusModel] if network is connected');
      expect(
        actualNetworkProvider.networkStatusModel,
        networkUnhealthyModel,
      );

      testPrint('Should return [networkStatusModel: connectedNetworkStatusModel.ur] if network is connected');
      expect(
        actualNetworkProvider.networkUri,
        networkUnhealthyModel.uri,
      );

      testPrint('Should return [isConnected: true] if network is connected');
      expect(
        actualNetworkProvider.isConnected,
        true,
      );

      // Act
      await actualNetworkProvider.handleEvent(NetworkDisconnectEvent());

      // Assert
      testPrint('Should return NetworkDisconnectedState if network is disconnected');
      expect(
        actualNetworkProvider.networkState,
        NetworkDisconnectedState(),
      );

      testPrint('Should return [networkStatusModel: null] if network is disconnected');
      expect(
        actualNetworkProvider.networkStatusModel,
        null,
      );

      testPrint('Should return [networkUri: null] if network is disconnected');
      expect(
        actualNetworkProvider.networkUri,
        null,
      );

      testPrint('Should return [isConnected: false] if network is disconnected');
      expect(
        actualNetworkProvider.isConnected,
        false,
      );
    });

    test(
        'Should call NetworkConnectFromUrlEvent without errors, emit assigned AListState and modify NetworkProvider fields',
        () async {
      // Assign
      NetworkProvider actualNetworkProvider = NetworkProvider();

      // Assert
      testPrint('Should return NetworkDisconnectedState if network is not connected');
      expect(
        actualNetworkProvider.networkState,
        NetworkDisconnectedState(),
      );

      testPrint('Should return [networkStatusModel: null] if network is not connected');
      expect(
        actualNetworkProvider.networkStatusModel,
        null,
      );

      testPrint('Should return [networkUri: null] if network is not connected');
      expect(
        actualNetworkProvider.networkUri,
        null,
      );

      testPrint('Should return [isConnected: false] if network is not connected');
      expect(
        actualNetworkProvider.isConnected,
        false,
      );

      // Act
      await actualNetworkProvider.handleEvent(NetworkConnectFromUrlEvent(optionalNetworkUri: Uri.parse(miroUri)));

      // Assert
      testPrint('Should return NetworkConnectedState if network is connected');
      expect(
        actualNetworkProvider.networkState,
        NetworkConnectedState(networkOnlineModel: networkUnhealthyModel),
      );

      testPrint('Should return [networkStatusModel: connectedNetworkStatusModel] if network is connected');
      expect(
        actualNetworkProvider.networkStatusModel,
        networkUnhealthyModel,
      );

      testPrint('Should return [networkStatusModel: connectedNetworkStatusModel.ur] if network is connected');
      expect(
        actualNetworkProvider.networkUri,
        networkUnhealthyModel.uri,
      );

      testPrint('Should return [isConnected: true] if network is connected');
      expect(
        actualNetworkProvider.isConnected,
        true,
      );
    });

    test(
        'Should call NetworkConnectFromUrlEvent without errors, emit assigned AListState and modify NetworkProvider fields',
        () async {
      // Assign
      NetworkProvider actualNetworkProvider = NetworkProvider();

      // Assert
      testPrint('Should return NetworkDisconnectedState if network is not connected');
      expect(
        actualNetworkProvider.networkState,
        NetworkDisconnectedState(),
      );

      testPrint('Should return [networkStatusModel: null] if network is not connected');
      expect(
        actualNetworkProvider.networkStatusModel,
        null,
      );

      testPrint('Should return [networkUri: null] if network is not connected');
      expect(
        actualNetworkProvider.networkUri,
        null,
      );

      testPrint('Should return [isConnected: false] if network is not connected');
      expect(
        actualNetworkProvider.isConnected,
        false,
      );

      // Act
      await actualNetworkProvider.handleEvent(NetworkSetUpEvent(networkUnhealthyModel));

      // Assert
      testPrint('Should return NetworkConnectedState after call NetworkSetUpEvent');
      expect(
        actualNetworkProvider.networkState,
        NetworkConnectedState(networkOnlineModel: networkUnhealthyModel),
      );

      testPrint('Should return [networkStatusModel: connectedNetworkStatusModel] after call NetworkSetUpEvent');
      expect(
        actualNetworkProvider.networkStatusModel,
        networkUnhealthyModel,
      );

      testPrint('Should return [networkStatusModel: connectedNetworkStatusModel.uri] after call NetworkSetUpEvent');
      expect(
        actualNetworkProvider.networkUri,
        networkUnhealthyModel.uri,
      );

      testPrint('Should return [isConnected: true] after call NetworkSetUpEvent');
      expect(
        actualNetworkProvider.isConnected,
        true,
      );
    });

    test(
        'Should call NetworkConnectFromUrlEvent without errors, emit assigned AListState and modify NetworkProvider fields',
        () async {
      // Assign
      NetworkProvider actualNetworkProvider = NetworkProvider();

      // Assert
      testPrint('Should return NetworkDisconnectedState if network is not connected');
      expect(
        actualNetworkProvider.networkState,
        NetworkDisconnectedState(),
      );

      testPrint('Should return [networkStatusModel: null] if network is not connected');
      expect(
        actualNetworkProvider.networkStatusModel,
        null,
      );

      testPrint('Should return [networkUri: null] if network is not connected');
      expect(
        actualNetworkProvider.networkUri,
        null,
      );

      testPrint('Should return [isConnected: false] if network is not connected');
      expect(
        actualNetworkProvider.isConnected,
        false,
      );

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      await actualNetworkProvider.handleEvent(NetworkSetUpEvent(networkUnhealthyModel, connectingStateRequired: true));

      // Assert
      testPrint(
          'Should return NetworkDisconnectedState if connectingStateRequired param is true and state is not NetworkConnectingState');
      expect(
        actualNetworkProvider.networkState,
        NetworkDisconnectedState(),
      );

      testPrint(
          'Should return [networkStatusModel: null] if connectingStateRequired param is true and state is not NetworkConnectingState');
      expect(
        actualNetworkProvider.networkStatusModel,
        null,
      );

      testPrint(
          'Should return [networkUri: null] if connectingStateRequired param is true and state is not NetworkConnectingState');
      expect(
        actualNetworkProvider.networkUri,
        null,
      );

      testPrint(
          'Should return [isConnected: false] if connectingStateRequired param is true and state is not NetworkConnectingState');
      expect(
        actualNetworkProvider.isConnected,
        false,
      );
    });
  });
}
