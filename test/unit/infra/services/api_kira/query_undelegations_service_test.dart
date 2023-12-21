import 'package:decimal/decimal.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_undelegations/request/query_undelegations_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/query_undelegations_service.dart';
import 'package:miro/shared/models/tokens/token_alias_model.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/undelegations/undelegation_model.dart';
import 'package:miro/shared/models/validators/validator_simplified_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/query_undelegations_service_test.dart --platform chrome --null-assertions
Future<void> main() async {
  await initMockLocator();
  final QueryUndelegationsService actualUndelegationsService = globalLocator<QueryUndelegationsService>();

  group('Tests of QueryUndelegationsService.getValidatorStakingModelList() method', () {
    test('Should return [PageData<ValidatorStakingModel>] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryUndelegationsReq actualQueryUndelegationsReq = const QueryUndelegationsReq(
        undelegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
        offset: 0,
        limit: 10,
      );

      // Act
      PageData<UndelegationModel> actualUndelegationModelList = await actualUndelegationsService.getUndelegationModelList(actualQueryUndelegationsReq);

      // Assert
      PageData<UndelegationModel> expectedValidatorStakingModelList = PageData<UndelegationModel>(
        listItems: <UndelegationModel>[
          UndelegationModel(
            id: 2,
            validatorSimplifiedModel: ValidatorSimplifiedModel(
              walletAddress: WalletAddress.fromBech32('kira1ymx5gpvswq0cmj6zkdxwa233sdgq2k5zzfge8w'),
              moniker: 'GENESIS VALIDATOR',
              logo: 'https://avatars.githubusercontent.com/u/114292385?s=200',
            ),
            tokens: <TokenAmountModel>[
              TokenAmountModel(
                defaultDenominationAmount: Decimal.fromInt(2000),
                tokenAliasModel: TokenAliasModel.local('ukex'),
              ),
            ],
            lockedUntil: DateTime.fromMillisecondsSinceEpoch(1701181197000)
          ),
        ],
        lastPageBool: true,
        blockDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
        cacheExpirationDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
      );

      expect(actualUndelegationModelList, expectedValidatorStakingModelList);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryUndelegationsReq actualQueryUndelegationsReq = const QueryUndelegationsReq(
        undelegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
      );
      // Assert
      expect(
        actualUndelegationsService.getUndelegationModelList(actualQueryUndelegationsReq),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryUndelegationsReq actualQueryUndelegationsReq = const QueryUndelegationsReq(
        undelegatorAddress: 'kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx',
      );
      // Assert
      expect(
        actualUndelegationsService.getUndelegationModelList(actualQueryUndelegationsReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
