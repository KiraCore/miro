import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/dto/api_cosmos/query_balance/response/query_balance_resp.dart';
import 'package:miro/infra/services/api_cosmos/query_balance_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_cosmos/query_balance_service_test.dart --platform chrome
//ignore_for_file: avoid_print
void main() {
  group('Tests of getAccountBalance() method', () {
    test('Should return specific account balances list', () async {
      await initLocator();

      final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      QueryBalanceReq queryBalanceReq = QueryBalanceReq(address: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      testPrint('Data request');
      QueryBalanceResp? queryBalanceResp = await queryBalanceService.getAccountBalance(networkUri, queryBalanceReq);

      testPrint('Data return');
      print(queryBalanceResp);
      print('');
    });
  });
}