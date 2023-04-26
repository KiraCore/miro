import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_interx_status/query_interx_status_resp.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_interx_status_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/query_interx_status_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final QueryInterxStatusService actualQueryInterxStatusService = globalLocator<QueryInterxStatusService>();

  group('Tests of QueryInterxStatusService.getQueryInterxStatusResp() method', () {
    test('Should return [QueryInterxStatusResp] if given [url represents interx server] and [interx ONLINE]', () async {
      final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');

      TestUtils.printInfo('Data request');
      try {
        QueryInterxStatusResp actualQueryInterxStatusResp = await actualQueryInterxStatusService.getQueryInterxStatusResp(networkUri);

        TestUtils.printInfo('Data return');
        print(actualQueryInterxStatusResp);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Cannot fetch [QueryInterxStatusResp] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Cannot parse [QueryInterxStatusResp] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });

    test('Should throw [DioConnectException] if given [url is NOT interx server] or [interx OFFLINE]', () async {
      final Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://ThisNetworkDoesNotExist.kira.network/');

      try {
        QueryInterxStatusResp actualQueryInterxStatusResp = await actualQueryInterxStatusService.getQueryInterxStatusResp(networkUri);
        TestUtils.printError('query_interx_status_service_test.dart: Got unexpected response for $networkUri: ${actualQueryInterxStatusResp}');
      } on DioConnectException catch (_) {
        print('Test passed. Got [DioConnectException] as expected');
      } catch (e) {
        TestUtils.printError('query_interx_status_service_test.dart: Got unexpected exception for $networkUri: ${e}');
      }
    });
  });
}
