import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_kira_tokens_aliases_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_default_denom_model.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_kira_tokens_aliases_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryKiraTokensAliasesService queryKiraTokensAliasesService = globalLocator<QueryKiraTokensAliasesService>();

  group('Tests of QueryKiraTokensAliasesService.getTokenAliases() method', () {
    test('Should return [List of TokenAliasModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      List<TokenAliasModel> actualTokenAliasModelList = await queryKiraTokensAliasesService.getTokenAliasModels();
      
      // Assert
      List<TokenAliasModel> expectedTokenAliasModelList = <TokenAliasModel>[
        TestUtils.kexTokenAliasModel,
      ];

      expect(actualTokenAliasModelList, expectedTokenAliasModelList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensAliasesService.getTokenAliasModels,
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensAliasesService.getTokenAliasModels,
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
      TokenDefaultDenomModel expectedTokenDefaultDenom = TokenDefaultDenomModel(
        bech32AddressPrefix: 'kira',
        defaultTokenAliasModel: TestUtils.kexTokenAliasModel,
      );

      expect(actualTokenDefaultDenomModel, expectedTokenDefaultDenom);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        queryKiraTokensAliasesService.getTokenDefaultDenomModel(networkUri),
        throwsA(isA<DioParseException>()),
      );
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
