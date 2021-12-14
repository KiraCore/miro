import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_cosmos/query_account/response/query_account_resp.dart';
import 'package:miro/infra/services/api_cosmos/query_account_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_cosmos/query_account_service_test.dart --platform chrome
//ignore_for_file: avoid_print
void main() {
  group('Tests of fetchQueryAccount() method', () {
    test('Should return the account data that contains current account number and sequence', () async {
      await initLocator();

      final QueryAccountService queryAccountService = globalLocator<QueryAccountService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      String actualAddress = 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx';

      testPrint('Data request');
      QueryAccountResp? queryAccountResp =
          await queryAccountService.fetchQueryAccount(actualAddress, customUri: networkUri);

      testPrint('Data return');
      print(queryAccountResp);
      print('');
    });
  });
}
