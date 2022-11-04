import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_network_properties_service.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_network_properties_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryNetworkPropertiesService queryNetworkPropertiesService = globalLocator<QueryNetworkPropertiesService>();

  group('Tests of getMinTxFee() method', () {
    test('Should return TokenAmountModel with current transaction fee', () async {
      TestUtils.printInfo('Data request');
      try {
        TokenAmountModel actualTokenAmountModel = await queryNetworkPropertiesService.getMinTxFee();

        TestUtils.printInfo('Data return');
        print(actualTokenAmountModel);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_network_properties_service_test.dart: Cannot fetch TokenAmountModel for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_network_properties_service_test.dart: Cannot parse TokenAmountModel for URI $networkUri: ${e}');
      }
    });
  });
}
