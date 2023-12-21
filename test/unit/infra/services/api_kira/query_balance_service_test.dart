import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_balance_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();
  const String actualAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

  PageData<BalanceModel> expectedBalancesPageData = PageData<BalanceModel>(
    lastPageBool: true,
    blockDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
    cacheExpirationDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
    listItems: <BalanceModel>[
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.parse('9878'),
          tokenAliasModel: TokenAliasModel.local('lol'),
        ),
      ),
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.parse('90000000000000000000000000'),
          tokenAliasModel: TokenAliasModel.local('samolean'),
        ),
      ),
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.parse('199779999999631'),
          tokenAliasModel: TokenAliasModel.local('test'),
        ),
      ),
      BalanceModel(
        tokenAmountModel: TokenAmountModel(
          defaultDenominationAmount: Decimal.parse('856916'),
          tokenAliasModel: TokenAliasModel.local('ukex'),
        ),
      ),
    ],
  );

  group('Tests of QueryBalanceService.getBalanceModelList() method', () {
    test('Should return [PageData<BalanceModel>] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryBalanceReq actualQueryBalanceReq = const QueryBalanceReq(address: actualAddress, offset: 0, limit: 10);

      // Act
      PageData<BalanceModel> actualBalancesPageData = await queryBalanceService.getBalanceModelList(actualQueryBalanceReq);

      // Assert
      expect(actualBalancesPageData, expectedBalancesPageData);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryBalanceReq actualQueryBalanceReq = const QueryBalanceReq(address: actualAddress, offset: 0, limit: 10);

      // Assert
      expect(
        () => queryBalanceService.getBalanceModelList(actualQueryBalanceReq),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryBalanceReq actualQueryBalanceReq = const QueryBalanceReq(address: actualAddress, offset: 0, limit: 10);

      // Assert
      expect(
        () => queryBalanceService.getBalanceModelList(actualQueryBalanceReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
