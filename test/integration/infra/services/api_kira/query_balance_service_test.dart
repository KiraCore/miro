import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_balance/request/query_balance_req.dart';
import 'package:miro/infra/services/api_kira/query_balance_service.dart';
import 'package:miro/shared/models/balances/balance_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_balance_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryBalanceService queryBalanceService = globalLocator<QueryBalanceService>();

  group('Tests of getBalanceModelList() method', () {
    test('Should return specific account balances list', () async {
      QueryBalanceReq queryBalanceReq = const QueryBalanceReq(address: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      TestUtils.printInfo('Data request');
      try {
        List<BalanceModel>? actualBalanceModelList = await queryBalanceService.getBalanceModelList(queryBalanceReq);

        TestUtils.printInfo('Data return');
        print(actualBalanceModelList);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot fetch List<BalanceModel> for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_balance_service_test.dart: Cannot parse List<BalanceModel> for URI $networkUri: ${e}');
      }
    });
  });
}
