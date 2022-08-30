import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_resp.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final DepositsService depositsService = globalLocator<DepositsService>();

  group('Tests of getAccountDeposits() method', () {
    test('Should return specific account deposits list', () async {
      DepositsReq depositsReq = DepositsReq(account: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      TestUtils.printInfo('Data request');
      try {
        DepositsResp? actualDepositsResp = await depositsService.getAccountDeposits(depositsReq);

        TestUtils.printInfo('Data return');
        print(actualDepositsResp);
        print('');
      } on DioError catch (e) {
        TestUtils.printError('deposits_service_test.dart: Cannot fetch DepositsResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('deposits_service_test.dart: Cannot parse DepositsResp for URI $networkUri: ${e}');
      }
    });
  });
}
