import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/specific_blocs/network_connector/network_connector_cubit.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/providers/network_provider.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/network_model.dart';
import 'package:miro/test/mocks/api/api_status.dart' as api_status_mocks;
import 'package:miro/test/test_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/blocs/network_connector_cubit_test.dart --platform chrome
Future<void> main() async {
  setUpAll(TestWidgetsFlutterBinding.ensureInitialized);
  await initTestLocator();

  final NetworkConnectorCubit networkConnectorCubit = NetworkConnectorCubit(
    queryInterxStatusService: globalLocator<QueryInterxStatusService>(),
  );
  // Actual values for tests
  const String actualBrowserUrl = 'https://test.test/?rpc=https://online.kira.network';
  final NetworkModel actualNetworkModel = NetworkModel(
    name: 'test-network',
    url: 'https://online.kira.network',
    status: NetworkHealthStatus.waiting,
  );
  // Expected values of tests
  const String expectedConnectedNetworkUrl = 'https://online.kira.network';

  group('Test establishing a connection via connectFromUrl() method', () {
    final NetworkModel expectedNetworkModel = NetworkModel(
      name: 'https://online.kira.network',
      url: 'https://online.kira.network',
      status: NetworkHealthStatus.online,
      queryInterxStatus: QueryInterxStatusResp.fromJson(api_status_mocks.apiStatusMock),
    );

    test('Should correctly set network parameters after connecting to network', () async {
      await networkConnectorCubit.connectFromUrl(url: actualBrowserUrl);
      final NetworkModel? connectedNetworkModel = globalLocator<NetworkProvider>().networkModel;

      // Because the tested method doesn't work properly outside the test, we need to check method within one test
      testPrint('Should return NetworkConnectorConnectedState with connected NetworkModel');
      expect(
        networkConnectorCubit.state.toString(),
        NetworkConnectorConnectedState(
          currentNetwork: expectedNetworkModel,
        ).toString(),
      );

      testPrint('Should return true (isConnected) if network is connected');
      expect(
        connectedNetworkModel?.isConnected,
        true,
      );

      testPrint('Should return URL from actually connected network');
      expect(
        connectedNetworkModel?.parsedUri.toString(),
        expectedConnectedNetworkUrl,
      );
    });
  });

  group('Test establishing a connection via connect() method', () {
    final NetworkModel expectedNetworkModel = NetworkModel(
      name: 'test-network',
      url: 'https://online.kira.network',
      status: NetworkHealthStatus.online,
      queryInterxStatus: QueryInterxStatusResp.fromJson(api_status_mocks.apiStatusMock),
    );

    test('Should correctly set network parameters after connecting to network', () async {
      await networkConnectorCubit.connect(actualNetworkModel);
      final NetworkModel? connectedNetworkModel = globalLocator<NetworkProvider>().networkModel;

      testPrint('Should return NetworkConnectorConnectedState with connected NetworkModel');
      expect(
        networkConnectorCubit.state.toString(),
        NetworkConnectorConnectedState(
          currentNetwork: expectedNetworkModel,
        ).toString(),
      );

      testPrint('Should return true (isConnected) if connected to network');
      expect(
        connectedNetworkModel?.isConnected,
        true,
      );

      testPrint('Should return URL from actually connected network');
      expect(
        connectedNetworkModel?.parsedUri.toString(),
        expectedConnectedNetworkUrl,
      );
    });
  });

  group('Test disconnecting from network via disconnect() method', () {
    final NetworkModel? actualNetworkModel = globalLocator<NetworkProvider>().networkModel;
    test('Should clear all network parameters after disconnect from network ', () {
      networkConnectorCubit.disconnect();

      testPrint('Should return NetworkConnectorInitialState if no network connected');
      expect(
        networkConnectorCubit.state,
        NetworkConnectorInitialState(),
      );

      testPrint('Should return null if no network is connected');
      expect(
        actualNetworkModel,
        null,
      );
    });
  });

  group('Tests of checkConnection() method', () {
    test('Should return true if can connect to network', () async {
      expect(
        await networkConnectorCubit.checkConnection('https://online.kira.network'),
        true,
      );
    });

    test('Should return false if cannot connect to network', () async {
      expect(
        await networkConnectorCubit.checkConnection('https://offline.kira.network'),
        false,
      );
    });
  });
}
