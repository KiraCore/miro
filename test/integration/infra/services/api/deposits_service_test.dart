import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_resp.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/shared/utils/network_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome
void main() {
  group('Tests of getAccountDeposits() method', () {
    test('Should return specific account deposits list', () async {
      await initLocator();

      final DepositsService depositsService = globalLocator<DepositsService>();
      final Uri uri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      DepositsReq depositsReq = DepositsReq(account: 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8');

      print('data request');
      DepositsResp? depositsResp = await depositsService.getAccountDeposits(uri, depositsReq);

      print('data return');
      print(depositsResp);
    });
  });
}
