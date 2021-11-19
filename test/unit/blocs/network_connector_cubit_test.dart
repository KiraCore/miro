import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/shared/models/network_status.dart';
import 'package:miro/test/test_locator.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_connector_cubit_test.dart --platform chrome
Future<void> main() async {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  await initTestLocator();

  // Actual values for tests
  const String actualBrowserUrl = 'https://test.test/?rpc=https://online.kira.network';
  final NetworkModel actualNetworkModelData = NetworkModel(
    name: 'test-network',
    url: 'https://online.kira.network',
    status: NetworkStatus.online(),
  );

  // Expected values of tests
  const String expectedConnectedNetworkUrl = 'https://online.kira.network';

  group('Test establishing a connection via connectFromUrl() method', () {
    blocTest<NetworkConnectorCubit, NetworkConnectorState>(
      'Should connect to network via specified url and return NetworkConnectorConnectedState',
      build: () => NetworkConnectorCubit(queryInterxStatusService: globalLocator<QueryInterxStatusService>()),
      //
      act: (NetworkConnectorCubit cubit) async => await cubit.connectFromUrl(url: actualBrowserUrl),
      //
      expect: () => <dynamic>[isA<NetworkConnectorConnectedState>()],
    );

    // After connecting, the connection parameters should be set correctly
    test('Should return true (isConnected) if network is connected', () {
      final NetworkModel? actualNetworkModel = globalLocator<NetworkProvider>().networkModel;
      expect(
        actualNetworkModel?.isConnected,
        true,
      );
    });

    test('Should return URL from actually connected network', () {
      final NetworkModel? actualNetworkModel = globalLocator<NetworkProvider>().networkModel;
      expect(
        actualNetworkModel?.parsedUri.toString(),
        expectedConnectedNetworkUrl,
      );
    });
  });

  group('Test establishing a connection via connect() method', () {
    blocTest<NetworkConnectorCubit, NetworkConnectorState>(
      'Should connect to network via specified NetworkModel and return NetworkConnectorConnectedState',
      build: () => NetworkConnectorCubit(queryInterxStatusService: globalLocator<QueryInterxStatusService>()),
      //
      act: (NetworkConnectorCubit cubit) async => await cubit.connect(actualNetworkModelData),
      //
      expect: () => <dynamic>[isA<NetworkConnectorConnectedState>()],
    );

    // After connecting, the connection parameters should be set correctly
    test('Should return true (isConnected) if connected to network', () {
      final NetworkModel? actualNetworkModel = globalLocator<NetworkProvider>().networkModel;
      expect(
        actualNetworkModel?.isConnected,
        true,
      );
    });

    test('Should return URL from actually connected network', () {
      final NetworkModel? actualNetworkModel = globalLocator<NetworkProvider>().networkModel;
      expect(
        actualNetworkModel?.parsedUri.toString(),
        expectedConnectedNetworkUrl,
      );
    });
  });
}
