import 'package:flutter_test/flutter_test.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/network_status.dart';

// To run this test type in console:
// fvm flutter test test/unit/providers/network_provider_test.dart --platform chrome
Future<void> main() async {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  final NetworkModel networkModel = NetworkModel(
    url: 'testnet-rpc.kira.network',
    name: 'testnet-test',
    status: NetworkStatus.offline(),
  );

  group('Tests of changeCurrentNetwork() in NetworkProvider', () {
    test('Should change "connected network" after providing NetworkModel data format', () {
      NetworkProvider networkProvider = NetworkProvider();

      expect(networkProvider.isConnected, false);
      expect(networkProvider.networkModel, null);

      networkProvider = NetworkProvider()..changeCurrentNetwork(networkModel);

      expect(networkProvider.isConnected, true);
      expect(networkProvider.networkModel, networkModel);
    });
  });
}
