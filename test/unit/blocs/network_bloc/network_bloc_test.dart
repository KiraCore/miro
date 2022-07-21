import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_connect_from_url_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_disconnect_event.dart';
import 'package:miro/blocs/specific_blocs/network/events/network_set_up_event.dart';
import 'package:miro/blocs/specific_blocs/network/network_bloc.dart';
import 'package:miro/blocs/specific_blocs/network/network_state.dart';
import 'package:miro/shared/models/network/network_info_model.dart';
import 'package:miro/shared/models/network/status/network_unknown_model.dart';
import 'package:miro/shared/models/network/status/online/interx_error.dart';
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
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.parse('2021-11-04T12:42:54.394946399Z'),
    ),
    interxErrors: const <InterxError>[InterxError.versionOutdated],
  );

  NetworkHealthyModel networkHealthyModel = NetworkHealthyModel(
    uri: Uri.parse('https://healthy.kira.network'),
    networkInfoModel: NetworkInfoModel(
      chainId: 'localnet-1',
      latestBlockHeight: 108843,
      latestBlockTime: DateTime.now(),
    ),
  );

  group('Tests of network connection process using NetworkConnectEvent', () {
    test('Should return expected states assigned to specified events', () async {
      // Assign
      NetworkBloc networkBloc = NetworkBloc();

      // Act
      NetworkState actualNetworkState = networkBloc.state;

      // Assert
      NetworkState expectedNetworkState = const NetworkState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkConnectEvent(networkUnknownModel));
      await Future<void>.delayed(const Duration(milliseconds: 40));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkState.connecting(networkUnknownModel);
      testPrint('Should return NetworkState with NetworkUnknownModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkState.connected(networkUnhealthyModel);
      testPrint('Should return NetworkState with NetworkUnhealthyModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = const NetworkState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);
    });
  });

  group('Tests of network connection process using NetworkConnectFromUrlEvent', () {
    test('Should return expected states assigned to specified events', () async {
      // Assign
      NetworkBloc networkBloc = NetworkBloc();

      // Act
      NetworkState actualNetworkState = networkBloc.state;

      // Assert
      NetworkState expectedNetworkState = const NetworkState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkConnectFromUrlEvent(optionalNetworkUri: Uri.parse(miroUri)));
      await Future<void>.delayed(const Duration(milliseconds: 40));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkState.connecting(healthyNetworkUnknownModel);
      testPrint('Should return NetworkState with NetworkUnknownModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkState.connected(networkHealthyModel);
      testPrint('Should return NetworkState with NetworkHealthyModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = const NetworkState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);
    });
  });

  group('Tests of network connection process, when user select network while other network is connecting', () {
    test('Should return expected states assigned to specified events', () async {
      // Assign
      NetworkBloc networkBloc = NetworkBloc();

      // Act
      NetworkState actualNetworkState = networkBloc.state;

      // Assert
      NetworkState expectedNetworkState = const NetworkState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkConnectFromUrlEvent(optionalNetworkUri: Uri.parse(miroUri)));
      await Future<void>.delayed(const Duration(milliseconds: 40));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkState.connecting(healthyNetworkUnknownModel);
      testPrint('Should return NetworkState with NetworkUnknownModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkSetUpEvent(networkUnhealthyModel, connectingStateRequired: true));
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = NetworkState.connected(networkUnhealthyModel);
      testPrint('Should return NetworkState with NetworkUnhealthyModel set');
      expect(actualNetworkState, expectedNetworkState);

      // Act
      networkBloc.add(NetworkDisconnectEvent());
      await Future<void>.delayed(const Duration(milliseconds: 100));
      actualNetworkState = networkBloc.state;

      // Assert
      expectedNetworkState = const NetworkState.disconnected();
      testPrint('Should return NetworkState without ANetworkStatusModel set');
      expect(actualNetworkState, expectedNetworkState);
    });
  });
}
