import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_kira_tokens_rates_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryKiraTokensRatesService queryKiraTokensRatesService = globalLocator<QueryKiraTokensRatesService>();

  group('Tests of getTokenRates() method', () {
    test('Should return all token rates', () async {
      TestUtils.printInfo('Data request');
      try {
        QueryKiraTokensRatesResp actualQueryKiraTokensRatesResp = await queryKiraTokensRatesService.getTokenRates();

        TestUtils.printInfo('Data return');
        print(actualQueryKiraTokensRatesResp);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_kira_tokens_rates_service_test.dart: Cannot fetch QueryKiraTokensRatesResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_kira_tokens_rates_service_test.dart: Cannot parse QueryKiraTokensRatesResp for URI $networkUri: ${e}');
      }
    });
  });
}
