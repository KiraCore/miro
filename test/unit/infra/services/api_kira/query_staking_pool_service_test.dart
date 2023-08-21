import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_staking_pool_service.dart';
import 'package:miro/shared/models/staking_pool/staking_pool_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_staking_pool_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();

  final QueryStakingPoolService queryStakingPoolService = globalLocator<QueryStakingPoolService>();

  group('Tests of QueryStakingPoolService.getStakingPoolModel() method', () {
    test('Should return [StakingPoolModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      WalletAddress actualValidatorWalletAddress = WalletAddress.fromBech32('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');

      // Act
      StakingPoolModel actualStakingPoolModel = await queryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress);

      // Assert
      StakingPoolModel expectedStakingPoolModel = StakingPoolModel(
        id: 1,
        totalDelegators: 1,
        commission: '10%',
        slashed: '0%',
        tokens: const <String>['frozen', 'ubtc', 'ukex', 'xeth'],
        // TokenAmountModel(lowestDenominationAmount: Decimal.parse(e.amount), tokenAliasModel: TokenAliasModel.local(e.denom)))
        votingPower: <TokenAmountModel>[
          TokenAmountModel(
            lowestDenominationAmount: Decimal.parse('100'),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          )
        ],
      );

      expect(actualStakingPoolModel, expectedStakingPoolModel);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      WalletAddress actualValidatorWalletAddress = WalletAddress.fromBech32('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');

      // Assert
      expect(
        queryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      WalletAddress actualValidatorWalletAddress = WalletAddress.fromBech32('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');

      // Assert
      expect(
        queryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
