import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/models/tokens/token_denomination_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();
  final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  TokenAliasModel tokenAliasModel1 = TestUtils.kexTokenAliasModel;
  TokenAliasModel tokenAliasModel2 = const TokenAliasModel(
    name: 'ABCD',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'abcd', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'ABCD', decimals: 6),
  );
  TokenAliasModel tokenAliasModel3 = const TokenAliasModel(
    name: 'POLY AI',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'poly-ai', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'AI', decimals: 6),
  );
  TokenAliasModel tokenAliasModel4 = const TokenAliasModel(
    name: 'Bitalgo',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'bitalgo', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'ALG', decimals: 6),
  );
  TokenAliasModel tokenAliasModel5 = const TokenAliasModel(
    name: 'ASD',
    defaultTokenDenominationModel: TokenDenominationModel(name: 'bitmax-token', decimals: 0),
    networkTokenDenominationModel: TokenDenominationModel(name: 'ASD', decimals: 6),
  );

  List<String> actualRequestTokens = <String>['ukex', 'abcd', 'poly-ai', 'bitalgo', 'bitmax-token'];

  group('Tests of QueryKiraTokensAliasesService.getAliasesByTokenNames() method', () {
    test('Should return [List of TokenAliasModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      List<TokenAliasModel> actualTokenAliasModelList = await queryKiraTokensAliasesService.getAliasesByTokenNames(actualRequestTokens);

      // Assert
      List<TokenAliasModel> expectedTokenAliasModelList = <TokenAliasModel>[
        tokenAliasModel1,
        tokenAliasModel2,
        tokenAliasModel3,
        tokenAliasModel4,
        tokenAliasModel5
      ];

      expect(actualTokenAliasModelList, expectedTokenAliasModelList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensAliasesService.getAliasesByTokenNames(actualRequestTokens),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensAliasesService.getAliasesByTokenNames(actualRequestTokens),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of QueryKiraTokensAliasesService.getTokenDefaultDenomModel() method', () {
    test('Should return [TokenDefaultDenomModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      TokenDefaultDenomModel actualTokenDefaultDenomModel = await queryKiraTokensAliasesService.getTokenDefaultDenomModel(networkUri);

      // Assert
      TokenDefaultDenomModel expectedTokenDefaultDenomModel = TokenDefaultDenomModel(
        valuesFromNetworkExistBool: true,
        bech32AddressPrefix: 'kira',
        defaultTokenAliasModel: tokenAliasModel1,
      );

      expect(actualTokenDefaultDenomModel, expectedTokenDefaultDenomModel);
    });

    test('Should return [TokenDefaultDenomModel.empty()] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      TokenDefaultDenomModel actualTokenDefaultDenomModel = await queryKiraTokensAliasesService.getTokenDefaultDenomModel(networkUri);

      // Assert
      TokenDefaultDenomModel expectedTokenDefaultDenom = TokenDefaultDenomModel.empty();

      expect(actualTokenDefaultDenomModel, expectedTokenDefaultDenom);
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensAliasesService.getTokenDefaultDenomModel(networkUri),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
