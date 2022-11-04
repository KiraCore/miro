import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_execution_fee_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_execution_fee_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  const String messageType = 'send';
  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryExecutionFeeService queryExecutionFeeService = globalLocator<QueryExecutionFeeService>();

  group('Tests of getExecutionFeeForMessage() method', () {
    test('Should return fee for provided message type', () async {
      TestUtils.printInfo('Data request');
      try {
        TokenAmountModel actualTokenAmountModel = await queryExecutionFeeService.getExecutionFeeForMessage(messageType);

        TestUtils.printInfo('Data return');
        print(actualTokenAmountModel.toString());
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_execution_fee_service_test.dart: Cannot fetch TokenAmountModel for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_execution_fee_service_test.dart: Cannot parse TokenAmountModel for URI $networkUri: ${e}');
      }
    });
  });
}
