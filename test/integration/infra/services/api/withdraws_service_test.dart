import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/withdraws/request/withdraws_req.dart';
import 'package:miro/infra/dto/api/withdraws/response/withdraws_resp.dart';
import 'package:miro/infra/services/api/withdraws_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/withdraws_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final WithdrawsService withdrawsService = globalLocator<WithdrawsService>();

  group('Tests of getAccountWithdraws() method', () {
    test('Should return specific account withdraws list', () async {
      WithdrawsReq withdrawsReq = WithdrawsReq(account: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      TestUtils.printInfo('Data request');
      try {
        WithdrawsResp? actualWithdrawsResp = await withdrawsService.getAccountWithdraws(withdrawsReq);

        TestUtils.printInfo('Data return');
        print(actualWithdrawsResp);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('withdraws_service_test.dart: Cannot fetch WithdrawsResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('withdraws_service_test.dart: Cannot parse WithdrawsResp for URI $networkUri: ${e}');
      }
    });
  });
}
