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
  final QueryStakingPoolService actualQueryStakingPoolService = globalLocator<QueryStakingPoolService>();

  group('Tests of QueryStakingPoolService.getStakingPoolModel() method', () {
    test('Should return [StakingPoolModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      WalletAddress actualValidatorWalletAddress = WalletAddress.fromBech32('kira1c6slygj2tx7hzm0mn4qeflqpvngj73c2tgz20j');

      // Act
      StakingPoolModel actualStakingPoolModel = await actualQueryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress);

      // Assert
      StakingPoolModel expectedStakingPoolModel = StakingPoolModel(
        slashed: '0%',
        totalDelegators: 1,
        votingPower: <TokenAmountModel>[
          TokenAmountModel(
            defaultDenominationAmount: Decimal.fromInt(100),
            tokenAliasModel: TokenAliasModel.local('ukex'),
          ),
        ],
        commission: '10%',
        tokens: <TokenAliasModel>[
          TokenAliasModel.local('frozen'),
          TokenAliasModel.local('ubtc'),
          TokenAliasModel.local('ukex'),
          TokenAliasModel.local('xeth'),
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
        actualQueryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress),
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
        actualQueryStakingPoolService.getStakingPoolModel(actualValidatorWalletAddress),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
