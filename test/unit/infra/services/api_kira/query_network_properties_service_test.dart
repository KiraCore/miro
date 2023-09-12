import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_network_properties_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final QueryNetworkPropertiesService actualQueryNetworkPropertiesService = globalLocator<QueryNetworkPropertiesService>();

  const TokenAliasModel defaultFeeTokenAliasModel = TokenAliasModel(
    name: 'Kira',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  group('Tests of QueryNetworkPropertiesService.getTxFee() method', () {
    test('Should return [TokenAmountModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      TokenAmountModel actualTokenAmountModel = await actualQueryNetworkPropertiesService.getMinTxFee();

      // Assert
      TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
        defaultDenominationAmount: Decimal.parse('100'),
        tokenAliasModel: defaultFeeTokenAliasModel,
      );

      expect(actualTokenAmountModel, expectedTokenAmountModel);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualQueryNetworkPropertiesService.getMinTxFee,
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualQueryNetworkPropertiesService.getMinTxFee,
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
