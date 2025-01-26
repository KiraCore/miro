import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/config/remote_config.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/query_kira_tokens_aliases_resp.dart';
import 'package:miro/infra/dto/api_kira/query_kira_tokens_aliases/response/token_alias.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

@GenerateNiceMocks(<MockSpec<dynamic>>[
  MockSpec<RemoteConfig>(),
])
import 'query_kira_tokens_aliases_service_test.mocks.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  MockRemoteConfig mockRemoteConfig = MockRemoteConfig();
  globalLocator.registerLazySingleton<RemoteConfig>(() => mockRemoteConfig);

  when(mockRemoteConfig.init()).thenAnswer((_) async {});

  await initMockLocator();

  final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  group('Tests of QueryKiraTokensAliasesService.getTokenAliases() method', () {
    test('Should return [List of TokenAliasModel] if [aliases from remote config are VALID]', () async {
      // Arrange
      when(mockRemoteConfig.getAliases()).thenReturn(TestUtils.queryKiraTokensAliasesResp);

      // Act
      List<TokenAliasModel> actualTokenAliasModelList = queryKiraTokensAliasesService.getTokenAliasModels();

      // Assert
      List<TokenAliasModel> expectedTokenAliasModelList = <TokenAliasModel>[
        TestUtils.kexTokenAliasModel,
      ];

      expect(actualTokenAliasModelList, expectedTokenAliasModelList);
    });

    test('Should return empty list if aliases from remote config are EMPTY / INVALID', () async {
      // Arrange
      when(mockRemoteConfig.getAliases()).thenReturn(
        const QueryKiraTokensAliasesResp(tokenAliases: <TokenAlias>[], defaultDenom: '', bech32Prefix: ''),
      );

      // Assert
      expect(queryKiraTokensAliasesService.getTokenAliasModels(), <TokenAliasModel>[]);
    });
  });

  group('Tests of QueryKiraTokensAliasesService.getTokenDefaultDenomModel() method', () {
    test('Should return [TokenDefaultDenomModel] if [aliases from remote config are VALID]', () async {
      // Arrange
      when(mockRemoteConfig.getAliases()).thenReturn(TestUtils.queryKiraTokensAliasesResp);

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

    test('Should return [TokenDefaultDenomModel.empty()] if [aliases from remote config are EMPTY / INVALID]',
        () async {
      // Arrange
      when(mockRemoteConfig.getAliases()).thenReturn(
        const QueryKiraTokensAliasesResp(tokenAliases: <TokenAlias>[], defaultDenom: '', bech32Prefix: ''),
      );

      // Act
      TokenDefaultDenomModel actualTokenDefaultDenomModel = queryKiraTokensAliasesService.getTokenDefaultDenomModel();

      // Assert
      TokenDefaultDenomModel expectedTokenDefaultDenom = TokenDefaultDenomModel.empty();

      expect(actualTokenDefaultDenomModel, expectedTokenDefaultDenom);
    });
  });
}
