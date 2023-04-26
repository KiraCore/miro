import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/query_kira_tokens_rates_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_rates/response/token_rate.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_rates_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_kira_tokens_rates_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryKiraTokensRatesService queryKiraTokensRatesService = globalLocator<QueryKiraTokensRatesService>();

  group('Tests of QueryKiraTokensRatesService.getTokenRates() method', () {
    test('Should return [QueryKiraTokensRatesResp] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      QueryKiraTokensRatesResp actualQueryKiraTokensRatesResp = await queryKiraTokensRatesService.getTokenRates();

      // Assert
      QueryKiraTokensRatesResp expectedQueryKiraTokensRatesResp = const QueryKiraTokensRatesResp(
        data: <TokenRate>[
          TokenRate(denom: 'frozen', feePayments: true, feeRate: '0.1', stakeCap: '0.0', stakeMin: '1e-18.0', stakeToken: false),
          TokenRate(denom: 'ubtc', feePayments: true, feeRate: '10.0', stakeCap: '0.25', stakeMin: '1e-18.0', stakeToken: true),
          TokenRate(denom: 'ukex', feePayments: true, feeRate: '1.0', stakeCap: '0.5', stakeMin: '1e-18.0', stakeToken: true),
          TokenRate(denom: 'xeth', feePayments: true, feeRate: '0.1', stakeCap: '0.1', stakeMin: '1e-18.0', stakeToken: false),
        ],
      );

      expect(actualQueryKiraTokensRatesResp, expectedQueryKiraTokensRatesResp);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensRatesService.getTokenRates,
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensRatesService.getTokenRates,
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
