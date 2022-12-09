import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/app_config.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_execution_fee_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  const String messageType = 'send';
  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryExecutionFeeService queryExecutionFeeService = globalLocator<QueryExecutionFeeService>();
  final AppConfig appConfig = globalLocator<AppConfig>();

  group('Tests of getExecutionFeeForMessage() method', () {
    test('Should return TokenDenominationModel with 100 ukex ', () async {
      // Act
      TokenAmountModel actualTokenAmountModel = await queryExecutionFeeService.getExecutionFeeForMessage(messageType);

      // Assert
      TokenAmountModel expectedTokenAmountModel = TokenAmountModel(
        lowestDenominationAmount: Decimal.parse('100'),
        tokenAliasModel: appConfig.defaultFeeTokenAliasModel,
      );

      expect(actualTokenAmountModel, expectedTokenAmountModel);
    });
  });
}
