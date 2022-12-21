import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_account_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryAccountService queryAccountService = globalLocator<QueryAccountService>();

  group('Tests of fetchQueryAccount() method', () {
    test('Should return TxRemoteInfoModel containing current account number and sequence', () async {
      String actualAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      TestUtils.printInfo('Data request');
      try {
        TxRemoteInfoModel? actualTxRemoteInfoModel = await queryAccountService.getTxRemoteInfo(actualAddress);

        TestUtils.printInfo('Data return');
        print(actualTxRemoteInfoModel);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_account_service_test.dart: Cannot fetch TxRemoteInfoModel for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_account_service_test.dart: Cannot parse TxRemoteInfoModel for URI $networkUri: ${e}');
      }
    });
  });
}
