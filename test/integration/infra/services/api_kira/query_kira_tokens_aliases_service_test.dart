import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome
// ignore_for_file: avoid_print
void main() {
  group('Tests of getTokenAliases() method', () {
    test('Should return all token aliases', () async {
      await initLocator();

      final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();
      final Uri networkUri = NetworkUtils.parseUrl('https://testnet-rpc.kira.network');

      TestUtils.printInfo('Data request');
      QueryKiraTokensAliasesResp queryKiraTokensAliasesResp = await queryKiraTokensAliasesService.getTokenAliases(
        customNetworkUri: networkUri,
      );

      TestUtils.printInfo('Data return');
      print(queryKiraTokensAliasesResp);
      print('');
    });
  });
}
