import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
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

  final Uri networkUri = NetworkUtils.parseUrl('https://healthy.kira.network');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryNetworkPropertiesService queryNetworkPropertiesService = globalLocator<QueryNetworkPropertiesService>();

  const TokenAliasModel defaultFeeTokenAliasModel = TokenAliasModel(
    name: 'Kira',
    lowestTokenDenominationModel: TokenDenominationModel(name: 'ukex', decimals: 0),
    defaultTokenDenominationModel: TokenDenominationModel(name: 'KEX', decimals: 6),
  );

  group('Tests of getTxFee() method', () {
    test('Should return TokenAmountModel with 100 ukex', () async {
      // Act
      TokenAmountModel actualTokenAmountModel = await queryNetworkPropertiesService.getMinTxFee();

      // Assert
      TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.parse('100'),
        tokenAliasModel: defaultFeeTokenAliasModel,
      );

      expect(actualTokenAmountModel, expectedTokenAmountModel);
    });
  });
}
