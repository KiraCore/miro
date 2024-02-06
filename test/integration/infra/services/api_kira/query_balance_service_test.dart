import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_balance_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryBalanceService actualQueryBalanceService = globalLocator<QueryBalanceService>();

  group('Tests of QueryBalanceService.getBalanceModelList() method', () {
    test('Should return [PageData<BalanceModel>] for specific account', () async {
      String actualAccountAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';
      QueryBalanceReq actualQueryBalanceReq = QueryBalanceReq(address: actualAccountAddress, limit: 10, offset: 0);

      TestUtils.printInfo('Data request');
      try {
        PageData<BalanceModel> actualBalancesPageData = await actualQueryBalanceService.getBalanceModelList(actualQueryBalanceReq);

        TestUtils.printInfo('Data return');
        print(actualBalancesPageData);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot fetch [PageData<BalanceModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot parse [PageData<BalanceModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of QueryBalanceService.getBalancesByTokenNames() method', () {
    test('Should return [List<BalanceModel>] for specific account', () async {
      String actualAccountAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      TestUtils.printInfo('Data request');
      try {
        List<BalanceModel> actualBalanceList = await actualQueryBalanceService.getBalancesByTokenNames(actualAccountAddress, <String>['ukex']);

        TestUtils.printInfo('Data return');
        print(actualBalanceList);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot fetch [PageData<BalanceModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot parse [PageData<BalanceModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
