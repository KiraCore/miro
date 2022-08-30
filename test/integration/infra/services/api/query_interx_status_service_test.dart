import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_interx_status_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final QueryInterxStatusService queryInterxStatusService = globalLocator<QueryInterxStatusService>();

  group('Tests of getQueryInterxStatusResp() method', () {
    test('Should return network data if network belongs to kira and network is active', () async {
      final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');

      TestUtils.printInfo('Data request');
      try {
        QueryInterxStatusResp actualQueryInterxStatusResp = await queryInterxStatusService.getQueryInterxStatusResp(networkUri);

        TestUtils.printInfo('Data return');
        print(actualQueryInterxStatusResp.toString());
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Cannot fetch QueryInterxStatusResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Cannot parse QueryInterxStatusResp for URI $networkUri: ${e}');
      }
    });

    test('Should throw exception if network not belongs to kira or belongs to kira but network is disabled', () async {
      final Uri networkUri = NetworkUtils.parseUrl('https://facebook.com/');

      try {
        QueryInterxStatusResp actualQueryInterxStatusResp = await queryInterxStatusService.getQueryInterxStatusResp(networkUri);
        TestUtils.printError(
            'query_interx_status_service_test.dart: Got unexpected response for $networkUri: ${actualQueryInterxStatusResp.toString()}');
      } on DioError catch (_) {
        print('Test passed. Got DioError as expected');
      } catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Got unexpected exception for $networkUri: ${e}');
      }
    });
  });
}
