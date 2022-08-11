import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_cosmos/query_balance_service_test.dart --platform chrome
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();

  group('Tests of getAccountBalance() method', () {
    test('Should return specific account balances list', () async {
      QueryBalanceReq queryBalanceReq = QueryBalanceReq(address: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      TestUtils.printInfo('Data request');
      try {
        QueryBalanceResp? actualQueryBalanceResp = await queryBalanceService.getAccountBalance(queryBalanceReq);

        TestUtils.printInfo('Data return');
        print(actualQueryBalanceResp);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot fetch QueryBalanceResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot parse QueryBalanceResp for URI $networkUri: ${e}');
      }
    });
  });
}
