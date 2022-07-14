import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/deposits/request/deposit_req.dart';
import 'package:miro/infra/dto/api/deposits/response/deposits_resp.dart';
import 'package:miro/infra/services/api/deposits_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api/deposits_service_test.dart --platform chrome 
// Optional flags: --dart-define=TEST_INTERX_URL="127.0.0.1:11000" --dart-define=TEST_USER_1_ADDR="$TEST_USER_1_ADDR"
//ignore_for_file: avoid_print
void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  group('Tests of getAccountDeposits() method', () {
    test('Should return specific account deposits list', () async {
      await initLocator();

      const String envKIRATestRPC = String.fromEnvironment('TEST_INTERX_URL');
      const String envKIRATestUser1 = String.fromEnvironment('TEST_USER_1_ADDR');
      String rpc = envKIRATestRPC.isEmpty ? 'https://testnet-rpc.kira.network' : envKIRATestRPC;
      String account = envKIRATestUser1.isEmpty ? 'kira1axqn2nr8wcwy83gnx97ugypunfka30wt4xyul8' : envKIRATestUser1;
      
      testPrint('RPC Test Target: ${rpc}');
      testPrint('Account Test Target: ${account}');

      final DepositsService depositsService = globalLocator<DepositsService>();
      final Uri uri = NetworkUtils.parseUrl(rpc);

      DepositsReq depositsReq = DepositsReq(account: account);

      testPrint('Data request: ${depositsReq.toString()} -> ${uri}');
      DepositsResp? depositsResp = await depositsService.getAccountDeposits(uri, depositsReq);

      testPrint('Data return: ');
      print(depositsResp);
      print('');
    });
  });
}
