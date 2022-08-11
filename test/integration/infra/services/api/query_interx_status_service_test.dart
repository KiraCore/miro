import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/exceptions/interx_unavailable_exception.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_interx_status_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();
  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();

  String testnetRpcUrl = 'testnet-rpc.kira.network';

  group('Tests of getQueryInterxStatusResp() method', () {
    test('Should return network data if network belongs to kira and network is active', () async {
      final Uri uri = NetworkUtils.parseUrl('https://${testnetRpcUrl}');

      TestUtils.printInfo('Data request');
      QueryInterxStatusResp queryInterxStatusResp = await queryInterxStatusService.getQueryInterxStatusResp(uri);
      TestUtils.printInfo('Data return');
      print(queryInterxStatusResp.toString());
      print('');
    });

    test('Should throw exception if network not belongs to kira or belongs to kira but network is disabled', () async {
      final Uri uri = NetworkUtils.parseUrl('https://facebook.com/');

      try {
        await queryInterxStatusService.getQueryInterxStatusResp(uri);
        TestUtils.printError('Test failed');
      } catch (e) {
        if (e.runtimeType == InterxUnavailableException) {
          print('Test passed');
          print('Exception is ${e.runtimeType}');
        } else {
          TestUtils.printError('Test failed');
          TestUtils.printError('Exception is ${e.runtimeType}');
        }
      }
    });
  });
}
