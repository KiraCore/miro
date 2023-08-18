import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_account_service.dart';
import 'package:miro/shared/models/transactions/tx_remote_info_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_account_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryAccountService actualQueryAccountService = globalLocator<QueryAccountService>();

  group('Tests of QueryAccountService.getTxRemoteInfo() method', () {
    test('Should return [TxRemoteInfoModel] containing current account number and sequence', () async {
      String actualAccountAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      TestUtils.printInfo('Data request');
      try {
        TxRemoteInfoModel? actualTxRemoteInfoModel = await actualQueryAccountService.getTxRemoteInfo(actualAccountAddress);

        TestUtils.printInfo('Data return');
        print(actualTxRemoteInfoModel);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_account_service_test.dart: Cannot fetch [TxRemoteInfoModel] for URI $networkUri: ${e.dioError.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_account_service_test.dart: Cannot parse [TxRemoteInfoModel] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_account_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of QueryAccountService.isAccountRegistered() method', () {
    test('Should return [boolean value] identifying if account is registered (whether any tokens have ever been deposited into the account)', () async {
      String actualAccountAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      TestUtils.printInfo('Data request');
      try {
        bool? actualFetchAvailableBool = await actualQueryAccountService.isAccountRegistered(actualAccountAddress);

        TestUtils.printInfo('Data return');
        print(actualFetchAvailableBool);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_account_service_test.dart: Cannot fetch [boolean value] for URI $networkUri: ${e.dioError.message}');
      } catch (e) {
        TestUtils.printError('query_account_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
