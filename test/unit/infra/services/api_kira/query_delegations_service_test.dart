import 'package:flutter_test/flutter_test.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_delegations/request/query_delegations_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_delegations_service.dart';
import 'package:miro/shared/models/delegations/validator_staking_model.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_delegations_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  final QueryDelegationsService actualDelegationsService = globalLocator<QueryDelegationsService>();

  group('Tests of QueryDelegationsService.getValidatorStakingModelList() method', () {
    test('Should return [List<ValidatorStakingModel>] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryDelegationsReq actualQueryDelegationsReq = const QueryDelegationsReq(
        delegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
      );

      // Act
      List<ValidatorStakingModel> actualValidatorStakingModelList = await actualDelegationsService.getValidatorStakingModelList(actualQueryDelegationsReq);

      // Assert
      List<ValidatorStakingModel> expectedValidatorStakingModelList = <ValidatorStakingModel>[
        ValidatorStakingModel(
          commission: '0.1',
          stakingPoolStatus: StakingPoolStatus.enabled,
          tokens: <TokenAliasModel>[
            TokenAliasModel.local('frozen'),
            TokenAliasModel.local('ubtc'),
            TokenAliasModel.local('ukex'),
            TokenAliasModel.local('xeth'),
          ],
          validatorSimplifiedModel: ValidatorSimplifiedModel(
            walletAddress: WalletAddress.fromBech32('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
            valkeyWalletAddress: WalletAddress.fromBech32('kiravaloper1ymx5gpvswq0cmj6zkdxwa233sdgq2k5z3056lz'),
            moniker: 'GENESIS VALIDATOR',
            logo: 'https://avatars.githubusercontent.com/u/114292385?s=200',
          ),
        ),
      ];

      expect(actualValidatorStakingModelList, expectedValidatorStakingModelList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryDelegationsReq actualQueryDelegationsReq = const QueryDelegationsReq(
        delegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
      );
      // Assert
      expect(
        actualDelegationsService.getValidatorStakingModelList(actualQueryDelegationsReq),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryDelegationsReq actualQueryDelegationsReq = const QueryDelegationsReq(
        delegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
      );
      // Assert
      expect(
        actualDelegationsService.getValidatorStakingModelList(actualQueryDelegationsReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
