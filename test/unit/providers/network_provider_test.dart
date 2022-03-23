import 'package:flutter_test/flutter_test.dart';
import 'package:miro/providers/network_provider/network_events.dart';
import 'package:miro/providers/network_provider/network_provider.dart';
import 'package:miro/providers/network_provider/network_states.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/test/test_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/providers/network_provider_test.dart --platform chrome
Future<void> main() async {
  await initTestLocator();
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);

  final NetworkModel networkModel = NetworkModel(
    url: 'testnet-rpc.kira.network',
    name: 'testnet-test',
    status: NetworkHealthStatus.offline,
  );

  NetworkProvider networkProvider = NetworkProvider();

  group('Tests of initial NetworkProvider state', () {
    test('Should return DisconnectedNetworkState on first provider initialize', () {
      expect(networkProvider.state, DisconnectedNetworkState());
    });
  });

  group('Tests of NetworkProvider state after change network states', () {
    test('Should return ConnectedNetworkState when ConnectToNetworkEvent & SetUpNetworkEvent is called', () async {
      networkProvider
        ..handleEvent(ConnectToNetworkEvent(networkModel))
        ..handleEvent(SetUpNetworkEvent(networkModel));
      expect(networkProvider.state, ConnectedNetworkState(networkModel));
    });

    test(
        'Should return DisconnectedNetworkState when break connection (SetUpNetworkEvent without ConnectToNetworkEvent before is called)',
        () async {
      networkProvider
        ..handleEvent(ConnectToNetworkEvent(networkModel))
        ..handleEvent(DisconnectNetworkEvent())
        ..handleEvent(SetUpNetworkEvent(networkModel));
      expect(networkProvider.state, DisconnectedNetworkState());
    });

    test('Should return DisconnectedNetworkState when disconnect from network', () async {
      networkProvider
        ..state = ConnectedNetworkState(networkModel)
        ..handleEvent(DisconnectNetworkEvent());
      expect(networkProvider.state, DisconnectedNetworkState());
    });
  });

  group('Test NetworkProvider params on ConnectingNetworkState', () {
    test('Should return null if state is ConnectingNetworkState', () {
      networkProvider.state = ConnectingNetworkState(networkModel);
      expect(
        networkProvider.networkModel,
        null,
      );
    });

    test('Should return null if state is ConnectingNetworkState', () {
      networkProvider.state = ConnectingNetworkState(networkModel);
      expect(
        networkProvider.networkUri,
        null,
      );
    });
  });

  group('Test NetworkProvider params on DisconnectedNetworkState', () {
    test('Should return null if state is DisconnectedNetworkState', () {
      networkProvider.state = DisconnectedNetworkState();
      expect(
        networkProvider.networkModel,
        null,
      );
    });

    test('Should return null if state is DisconnectedNetworkState', () {
      networkProvider.state = DisconnectedNetworkState();
      expect(
        networkProvider.networkUri,
        null,
      );
    });
  });

  group('Test NetworkProvider params on ConnectedNetworkState', () {
    test('Should return [networkModel.parsedUri] if state is ConnectedNetworkState', () {
      networkProvider.state = ConnectedNetworkState(networkModel);
      expect(
        networkProvider.networkUri,
        networkModel.parsedUri,
      );
    });

    test('Should return networkModel if state is ConnectedNetworkState', () {
      networkProvider.state = ConnectedNetworkState(networkModel);
      expect(
        networkProvider.networkModel,
        networkModel,
      );
    });
  });
}
