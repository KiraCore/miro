import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_kira_tokens_rates_service_test.dart --platform chrome
// ignore_for_file: avoid_print
void main() {
  group('Tests of getTokenRates() method', () {
    test('Should return all token rates', () async {
      await initLocator();

      final QueryKiraTokensRatesService queryKiraTokensRatesService = globalLocator<QueryKiraTokensRatesService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      TestUtils.printInfo('Data request');
      QueryKiraTokensRatesResp queryKiraTokensRatesResp = await queryKiraTokensRatesService.getTokenRates(customNetworkUri: networkUri);

      TestUtils.printInfo('Data return');
      print(queryKiraTokensRatesResp);
      print('');
    });
  });
}
