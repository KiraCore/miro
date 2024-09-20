import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api/query_validators/request/query_validators_req.dart';
import 'package:miro/infra/dto/api/query_validators/response/query_validators_resp.dart';
import 'package:miro/infra/dto/api/query_validators/response/status.dart';
import 'package:miro/infra/dto/api/query_validators/response/validator.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api/query_validators_service.dart';
import 'package:miro/shared/models/validators/staking_pool_status.dart';
import 'package:miro/shared/models/validators/validator_model.dart';
import 'package:miro/shared/models/validators/validator_status.dart';
import 'package:miro/shared/models/wallet/address/a_wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api/query_validators_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final QueryValidatorsService queryValidatorsService = globalLocator<QueryValidatorsService>();

  group('Tests of QueryValidatorsService.getValidatorsList() method', () {
    test('Should return [PageData<ValidatorModel>] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq(limit: 10, offset: 0);

      // Act
      PageData<ValidatorModel> actualValidatorsPageData = await queryValidatorsService.getValidatorsList(actualQueryValidatorsReq);

      // Assert
      PageData<ValidatorModel> expectedValidatorsPageData = PageData<ValidatorModel>(
        lastPageBool: true,
        blockDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
        cacheExpirationDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
        listItems: <ValidatorModel>[
          ValidatorModel(
            top: 1,
            uptime: 100,
            moniker: 'OneStar',
            streak: '1303599',
            stakingPoolStatus: StakingPoolStatus.enabled,
            validatorStatus: ValidatorStatus.active,
            walletAddress: AWalletAddress.fromAddress('kira1fffuhtsuc6qskp4tsy5ptjssshynacj462ptdy'),
            valkey: 'kiravaloper1fffuhtsuc6qskp4tsy5ptjssshynacj4fvag4g',
          ),
          ValidatorModel(
            top: 2,
            uptime: 100,
            moniker: 'necrus',
            streak: '1303553',
            stakingPoolStatus: StakingPoolStatus.withdraw,
            validatorStatus: ValidatorStatus.active,
            walletAddress: AWalletAddress.fromAddress('kira1gfqq3kqn7tuhnpph4487d57c00dkptt3hefgkk'),
            valkey: 'kiravaloper1gfqq3kqn7tuhnpph4487d57c00dkptt3yl4tw6',
          ),
          ValidatorModel(
            top: 3,
            uptime: 100,
            moniker: 'apexnode',
            streak: '1303545',
            stakingPoolStatus: StakingPoolStatus.disabled,
            validatorStatus: ValidatorStatus.active,
            walletAddress: AWalletAddress.fromAddress('kira13hrpqkv53t82n2e72kfr3kuvvvr3565p234g3g'),
            valkey: 'kiravaloper13hrpqkv53t82n2e72kfr3kuvvvr3565pehftfy',
          ),
        ],
      );

      expect(actualValidatorsPageData, expectedValidatorsPageData);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq(limit: 10, offset: 0);

      // Assert
      expect(
        () => queryValidatorsService.getValidatorsList(actualQueryValidatorsReq),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq(limit: 10, offset: 0);

      // Assert
      expect(
        () => queryValidatorsService.getValidatorsList(actualQueryValidatorsReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of QueryValidatorsService.getValidatorsByAddresses() method', () {
    test('Should return [List of ValidatorModel] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      List<ValidatorModel>? actualValidatorModels = await queryValidatorsService.getValidatorsByAddresses(<String>[
        'kira1vxvugjt7u0lpzgkpv5hr7qwu2v4rx64d597s3l',
      ]);

      // Assert
      List<ValidatorModel> expectedValidatorModels = <ValidatorModel>[
        ValidatorModel(
          top: 44,
          uptime: 98,
          walletAddress: AWalletAddress.fromAddress('kira1vxvugjt7u0lpzgkpv5hr7qwu2v4rx64d597s3l'),
          valkey: 'kiravaloper1vxvugjt7u0lpzgkpv5hr7qwu2v4rx64d8rznfn',
          moniker: 'medium',
          streak: '1167583',
          validatorStatus: ValidatorStatus.active,
          stakingPoolStatus: StakingPoolStatus.disabled,
        ),
      ];
      expect(actualValidatorModels, expectedValidatorModels);
    });

    test('Should return [Empty list] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      List<ValidatorModel> actualValidatorList = await queryValidatorsService.getValidatorsByAddresses(<String>['kira1vxvugjt7u0lpzgkpv5hr7qwu2v4rx64d597s3l']);

      // Assert
      List<ValidatorModel> expectedValidatorList = const <ValidatorModel>[];
      expect(actualValidatorList, expectedValidatorList);
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryValidatorsService.getValidatorsByAddresses(<String>['kira1vxvugjt7u0lpzgkpv5hr7qwu2v4rx64d597s3l']),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of QueryValidatorsService.getQueryValidatorsResp() method', () {
    test('Should return [QueryValidatorsResp] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq(limit: 2, offset: 0);

      // Act
      QueryValidatorsResp? actualQueryValidatorsResp = await queryValidatorsService.getQueryValidatorsResp(actualQueryValidatorsReq);

      // Assert
      QueryValidatorsResp expectedQueryValidatorsResp = const QueryValidatorsResp(waiting: <String>[], validators: <Validator>[
        Validator(
          top: '1',
          address: 'kira1fffuhtsuc6qskp4tsy5ptjssshynacj462ptdy',
          valkey: 'kiravaloper1fffuhtsuc6qskp4tsy5ptjssshynacj4fvag4g',
          pubkey: 'PubKeyEd25519{ADA24467D0CF6E3138FDE687001DBAF66FB64C45A14966D4AFDA6998268F8858}',
          proposer: '6710EA386DFF11D2437F7A1EA909D7227DC3C41D',
          moniker: 'OneStar',
          status: 'ACTIVE',
          rank: '1303599',
          streak: '1303599',
          mischance: '0',
          mischanceConfidence: '0',
          startHeight: '3753',
          inactiveUntil: '1970-01-01T00:00:00Z',
          lastPresentBlock: '1307360',
          missedBlocksCounter: '4',
          producedBlocksCounter: '1303599',
          stakingPoolId: '1',
          stakingPoolStatus: 'ENABLED',
        ),
        Validator(
          top: '2',
          address: 'kira1gfqq3kqn7tuhnpph4487d57c00dkptt3hefgkk',
          valkey: 'kiravaloper1gfqq3kqn7tuhnpph4487d57c00dkptt3yl4tw6',
          pubkey: 'PubKeyEd25519{EE01DDF7AB5F42B1A0DEA031D8B3A175F4F5E120A737E254144D28783F7E4EBC}',
          proposer: 'E72D3657C38BB1FB6C8C9D938CD2D19BF34D9FE2',
          moniker: 'necrus',
          status: 'ACTIVE',
          rank: '1303553',
          streak: '1303553',
          mischance: '0',
          mischanceConfidence: '0',
          startHeight: '3556',
          inactiveUntil: '1970-01-01T00:00:00Z',
          lastPresentBlock: '1307360',
          missedBlocksCounter: '247',
          producedBlocksCounter: '1303553',
          validatorNodeId: '46bc0b2dc7860cc419f4022ae734e3731e27abf2',
          stakingPoolId: '2',
          stakingPoolStatus: 'WITHDRAW',
        )
      ]);

      expect(actualQueryValidatorsResp, expectedQueryValidatorsResp);
    });

    test('Should return [empty QueryValidatorsResp] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq();

      QueryValidatorsResp actualQueryValidatorsResp = await queryValidatorsService.getQueryValidatorsResp(actualQueryValidatorsReq);

      // Assert
      QueryValidatorsResp expectedQueryValidatorsResp = const QueryValidatorsResp(waiting: <String>[], validators: <Validator>[]);
      expect(actualQueryValidatorsResp, expectedQueryValidatorsResp);
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      QueryValidatorsReq actualQueryValidatorsReq = const QueryValidatorsReq();

      // Assert
      expect(
        () => queryValidatorsService.getQueryValidatorsResp(actualQueryValidatorsReq),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of QueryValidatorsService.getStatus() method', () {
    test('Should return [Status DTO] if [server HEALTHY] and [response data VALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      Status? actualStatus = await queryValidatorsService.getStatus(networkUri);

      // Assert
      Status expectedStatus = const Status(
        activeValidators: 319,
        pausedValidators: 14,
        inactiveValidators: 135,
        jailedValidators: 7,
        totalValidators: 475,
        waitingValidators: 302,
      );

      expect(actualStatus, expectedStatus);
    });

    test('Should throw [DioParseException] if [server HEALTHY] and [response data INVALID]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryValidatorsService.getStatus(networkUri),
        throwsA(isA<DioParseException>()),
      );
    });

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => queryValidatorsService.getStatus(networkUri),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
