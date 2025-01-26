import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  group('Tests of QueryKiraTokensAliasesService.getTokenAliases() method', () {
    test('Should return [List of TokenAliasModel]', () async {
      // Act
      List<TokenAliasModel> actualTokenAliasModelList = queryKiraTokensAliasesService.getTokenAliasModels();

      // Assert
      List<TokenAliasModel> expectedTokenAliasModelList = <TokenAliasModel>[
        TestUtils.kexTokenAliasModel,
      ];

      expect(actualTokenAliasModelList, expectedTokenAliasModelList);
    });
  });

  group('Tests of QueryKiraTokensAliasesService.getTokenDefaultDenomModel() method', () {
    test('Should return [TokenDefaultDenomModel]', () async {
      // Act
      TokenDefaultDenomModel actualTokenDefaultDenomModel = queryKiraTokensAliasesService.getTokenDefaultDenomModel();

      // Assert
      expect(
        actualTokenDefaultDenomModel,
        TokenDefaultDenomModel(
          valuesFromNetworkExistBool: true,
          bech32AddressPrefix: TestUtils.queryKiraTokensAliasesResp.bech32Prefix,
          defaultTokenAliasModel: TokenAliasModel.fromDto(TestUtils.queryKiraTokensAliasesResp.tokenAliases.first),
        ),
      );
    });
  });
}
