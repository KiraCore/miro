import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/interx_unavailable_exception.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/constants/network_health_status.dart';
import 'package:miro/shared/models/infra/interx_response_data.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_interx_status_service_test.dart --platform chrome
Future<void> main() async {
  await initLocator();
  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();

  String testnetRpcUrl = 'testnet-rpc.kira.network';

  group('Tests of getHealth() method', () {
    // If test fail, try with other kira network
    test('Should return NetworkHealthStatus.online if network belongs to kira and network is active', () async {
      final Uri uri = NetworkUtils.parseUrl('https://${testnetRpcUrl}');

      NetworkHealthStatus networkHealthStatus = await queryInterxStatusService.getHealth(uri);
      print(
          'NetworkHealthStatus.online == ${networkHealthStatus.toString()} - ${NetworkHealthStatus.online == networkHealthStatus}');
    });

    test(
        'Should return NetworkHealthStatus.online if network belongs to kira, network is active but url has bad scheme',
        () async {
      final Uri uri = NetworkUtils.parseUrl('http://${testnetRpcUrl}');

      NetworkHealthStatus networkHealthStatus = await queryInterxStatusService.getHealth(uri);
      print(
          'NetworkHealthStatus.online == ${networkHealthStatus.toString()} - ${NetworkHealthStatus.online == networkHealthStatus}');
    });

    test(
        'Should return NetworkHealthStatus.offline if network not belongs to kira or belongs to kira but network is disabled',
        () async {
      final Uri uri = NetworkUtils.parseUrl('https://facebook.com/');

      NetworkHealthStatus networkHealthStatus = await queryInterxStatusService.getHealth(uri);
      print(
          'NetworkHealthStatus.offline == ${networkHealthStatus.toString()} - ${NetworkHealthStatus.offline == networkHealthStatus}');
    });
  });

  group('Tests of getData() method', () {
    test('Should return network data if network belongs to kira and network is active', () async {
      final Uri uri = NetworkUtils.parseUrl('https://${testnetRpcUrl}');

      testPrint('Data request');
      InterxResponseData interxStatusResponse = await queryInterxStatusService.getData(uri);
      testPrint('Data return');
      print(interxStatusResponse.toString());
      print('');
    });

    test('Should return network data if network belongs to kira, network is active but url has bad scheme', () async {
      final Uri uri = NetworkUtils.parseUrl('http://${testnetRpcUrl}');

      testPrint('Data request');
      InterxResponseData interxStatusResponse = await queryInterxStatusService.getData(uri);
      testPrint('Data return');
      print(interxStatusResponse.toString());
      print('');
    });

    test('Should throw exception if network not belongs to kira or belongs to kira but network is disabled', () async {
      final Uri uri = NetworkUtils.parseUrl('https://facebook.com/');

      try {
        await queryInterxStatusService.getData(uri);
        testPrintError('Test failed');
      } catch (e) {
        if (e.runtimeType == InterxUnavailableException) {
          print('Test passed');
          print('Exception is ${e.runtimeType}');
        } else {
          testPrintError('Test failed');
          testPrintError('Exception is ${e.runtimeType}');
        }
      }
    });
  });
}
