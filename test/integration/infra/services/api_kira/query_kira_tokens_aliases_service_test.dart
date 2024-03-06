import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/integration/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await TestUtils.initIntegrationTest();

  final Uri networkUri = NetworkUtils.parseUrlToInterxUri('http://173.212.254.147:11000');
  await TestUtils.setupNetworkModel(networkUri: networkUri);

  final QueryKiraTokensAliasesService actualQueryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  group('Tests of QueryKiraTokensAliasesService.getTokenAliases() method', () {
    test('Should return [List of TokenAliasModel]', () async {
      TestUtils.printInfo('Data request');
      try {
        List<TokenAliasModel> actualTokenAliasModelList = await actualQueryKiraTokensAliasesService.getTokenAliasModels();

        TestUtils.printInfo('Data return');
        print(actualTokenAliasModelList);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError(
            'query_kira_tokens_aliases_service_test.dart: Cannot fetch [List<TokenAliasModel>] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_kira_tokens_aliases_service_test.dart: Cannot parse [List<TokenAliasModel>] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_kira_tokens_aliases_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });

  group('Tests of QueryKiraTokensAliasesService.getTokenDefaultDenomModel() method', () {
    test('Should return [TokenDefaultDenomModel]', () async {
      TestUtils.printInfo('Data request');
      try {
        TokenDefaultDenomModel actualTokenDefaultDenomModel = await actualQueryKiraTokensAliasesService.getTokenDefaultDenomModel(networkUri);

        TestUtils.printInfo('Data return');
        print(actualTokenDefaultDenomModel);
        print('');
      } on DioConnectException catch (e) {
        TestUtils.printError('query_kira_tokens_aliases_service_test.dart: Cannot fetch [TokenDefaultDenomModel] for URI $networkUri: ${e.dioException.message}');
      } on DioParseException catch (e) {
        TestUtils.printError('query_kira_tokens_aliases_service_test.dart: Cannot parse [TokenDefaultDenomModel] for URI $networkUri: ${e}');
      } catch (e) {
        TestUtils.printError('query_kira_tokens_aliases_service_test.dart: Unknown error for URI $networkUri: ${e}');
      }
    });
  });
}
