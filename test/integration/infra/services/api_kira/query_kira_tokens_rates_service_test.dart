import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_kira_tokens_rates_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryKiraTokensRatesService actualQueryKiraTokensRatesService = globalLocator<QueryKiraTokensRatesService>();

  group('Tests of QueryKiraTokensRatesService.getTokenRates() method', () {
    test('Should return [QueryKiraTokensRatesResp]', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryKiraTokensRatesResp actualQueryKiraTokensRatesResp = await actualQueryKiraTokensRatesService.getTokenRates();

        TestUtils.printInfo('Data return');
        print(actualQueryKiraTokensRatesResp);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError(
            'query_kira_tokens_rates_service_test.dart: Cannot fetch [QueryKiraTokensRatesResp] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_kira_tokens_rates_service_test.dart: Cannot parse [QueryKiraTokensRatesResp] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_kira_tokens_rates_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
