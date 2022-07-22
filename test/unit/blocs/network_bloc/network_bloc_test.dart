import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_connect_from_url_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/events/network_module_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_bloc.dart';
import 'package:miro/blocs/specific_blocs/network_module/network_module_state.dart';
import 'package:miro/shared/models/network/interx_error.dart';
import 'package:miro/shared/models/network/interx_error_type.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/network_healthy_model.dart';
import 'package:miro/shared/models/network/status/online/network_unhealthy_model.dart';
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_bloc/network_bloc_test.dart --platform chrome
Future<void> main() async {
  await initTestLocator();
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  String miroUri = 'https://miro.kira.network?rpc=https://healthy.kira.network';

  NetworkUnknownModel networkUnknownModel = NetworkUnknownModel(
    uri: Uri.parse('https://online.kira.network'),
  );

  NetworkUnknownModel healthyNetworkUnknownModel = NetworkUnknownModel(
    uri: Uri.parse('https://healthy.kira.network'),
  );

  NetworkUnhealthyModel networkUnhealthyModel = NetworkUnhealthyModel(
    uri: Uri.parse('https://online.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'testnet-7',
      interxVersion: '0.0.1',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
    ),
    interxError: InterxError(<InterxErrorType>[InterxErrorType.versionOutdated]),
  );

  NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    uri: Uri.parse('https://healthy.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'v0.4.11',
      interxVersion: '',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
    ),
  );

  group('Tests of network connection process using NetworkConnectEvent', () {
    test('Should return expected states assigned to specified events', () async {
      // Assign
      NetworkModuleBloc networkBloc = NetworkModuleBloc();

      // Act
      NetworkModuleState actualNetworkState = networkBloc.state;

      // Assert
      NetworkModuleState expectedNetworkState = const NetworkModuleState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleConnectEvent(networkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 40));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkModuleState.connecting(networkUnknownModel);
      testPrint('Should return NetworkState with NetworkUnknownModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkModuleState.connected(networkUnhealthyModel);
      testPrint('Should return NetworkState with NetworkUnhealthyModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = const NetworkModuleState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);
    });
  });

  group('Tests of network connection process using NetworkConnectFromUrlEvent', () {
    test('Should return expected states assigned to specified events', () async {
      // Assign
      NetworkModuleBloc networkBloc = NetworkModuleBloc();

      // Act
      NetworkModuleState actualNetworkState = networkBloc.state;

      // Assert
      NetworkModuleState expectedNetworkState = const NetworkModuleState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleConnectFromUrlEvent(optionalNetworkUri: Uri.parse(miroUri)));
      await Future<void>.delayed(const Duration(milliseconds: 40));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkModuleState.connecting(healthyNetworkUnknownModel);
      testPrint('Should return NetworkState with NetworkUnknownModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkModuleState.connected(networkHealthyModel);
      testPrint('Should return NetworkState with NetworkHealthyModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = const NetworkModuleState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);
    });
  });

  group('Tests of network connection process, when user select network while other network is connecting', () {
    test('Should return expected states assigned to specified events', () async {
      // Assign
      NetworkModuleBloc networkBloc = NetworkModuleBloc();

      // Act
      NetworkModuleState actualNetworkState = networkBloc.state;

      // Assert
      NetworkModuleState expectedNetworkState = const NetworkModuleState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleConnectFromUrlEvent(optionalNetworkUri: Uri.parse(miroUri)));
      await Future<void>.delayed(const Duration(milliseconds: 40));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkModuleState.connecting(healthyNetworkUnknownModel);
      testPrint('Should return NetworkState with NetworkUnknownModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleSetUpEvent(networkUnhealthyModel, connectingStateRequired: true));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkModuleState.connected(networkUnhealthyModel);
      testPrint('Should return NetworkState with NetworkUnhealthyModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkModuleDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = const NetworkModuleState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);
    });
  });
}
