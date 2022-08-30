import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initLocator();

  final Uri networkUri = NetworkUtils.parseUrl('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  group('Tests of getTokenAliases() method', () {
    test('Should return all token aliases', () async {
      TestUtils.printInfo('Data request');
      try {
        List<TokenAliasModel> actualTokenAliasModelList = await queryKiraTokensAliasesService.getTokenAliasModels();

        TestUtils.printInfo('Data return');
        print(actualTokenAliasModelList);
        print('');
      } on DioError catch (e) {
        TestUtils.printError(
            'query_kira_tokens_aliases_service_test.dart: Cannot fetch QueryKiraTokensAliasesResp for URI $networkUri: ${e.message}');
      } catch (e) {
        TestUtils.printError('query_kira_tokens_aliases_service_test.dart: Cannot parse QueryKiraTokensAliasesResp for URI $networkUri: ${e}');
      }
    });
  });
}
