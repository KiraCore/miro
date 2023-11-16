import 'package:flutter_test/flutter_test.dart';
import 'package:miro/blocs/widgets/kira/kira_list/abstract_list/models/page_data.dart';
import 'package:miro/config/locator.dart';
import 'package:miro/infra/dto/api_kira/query_identity_record_verify_requests/request/query_identity_record_verify_requests_by_approver_req.dart';
import 'package:miro/infra/exceptions/dio_connect_exception.dart';
import 'package:miro/infra/exceptions/dio_parse_exception.dart';
import 'package:miro/infra/services/api_kira/identity_records_service.dart';
import 'package:miro/shared/models/identity_registrar/ir_inbound_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_record_verification_request_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_user_profile_model.dart';
import 'package:miro/shared/models/identity_registrar/ir_verification_request_status.dart';
import 'package:miro/shared/models/tokens/token_amount_model.dart';
import 'package:miro/shared/models/wallet/wallet_address.dart';
import 'package:miro/shared/utils/network_utils.dart';
import 'package:miro/test/mock_locator.dart';
import 'package:miro/test/utils/test_utils.dart';

// To run this test type in console:
// fvm flutter test test/unit/infra/services/api_kira/identity_records_service_test.dart --platform chrome --null-assertions
// ignore_for_file: avoid_print
Future<void> main() async {
  await initMockLocator();

  final IdentityRecordsService actualIdentityRecordsService = globalLocator<IdentityRecordsService>();
  final WalletAddress actualWalletAddress = WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx');
  final IRRecordModel actualIrRecordModel = IRRecordModel(
    id: '3',
    key: 'username',
    value: 'somnitear',
    verifiersAddresses: <WalletAddress>[
      WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    ],
    pendingVerifiersAddresses: const <WalletAddress>[],
  );

  final IRModel expectedRequesterIRModel = IRModel(
    walletAddress: WalletAddress.fromBech32('kira143q8vxpvuykt9pq50e6hng9s38vmy844n8k9wx'),
    usernameIRRecordModel: IRRecordModel(
      id: '3',
      key: 'username',
      value: 'somnitear',
      verifiersAddresses: const <WalletAddress>[],
      pendingVerifiersAddresses: <WalletAddress>[
        WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
      ],
    ),
    descriptionIRRecordModel: const IRRecordModel.empty(key: 'description'),
    socialMediaIRRecordModel: const IRRecordModel.empty(key: 'social'),
    avatarIRRecordModel: const IRRecordModel(
      id: '2',
      key: 'avatar',
      value: 'https://avatars.githubusercontent.com/u/114292385',
      verifiersAddresses: <WalletAddress>[],
      pendingVerifiersAddresses: <WalletAddress>[],
    ),
    otherIRRecordModelList: <IRRecordModel>[
      IRRecordModel(
        id: '4',
        key: 'github',
        value: 'https://github.com/kiracore',
        verifiersAddresses: <WalletAddress>[
          WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
        ],
        pendingVerifiersAddresses: const <WalletAddress>[],
      ),
    ],
  );

  final IRUserProfileModel expectedIrUserProfileModel = IRUserProfileModel(
    walletAddress: WalletAddress.fromBech32('kira177lwmjyjds3cy7trers83r4pjn3dhv8zrqk9dl'),
    username: 'somnitear',
    avatarUrl: 'https://avatars.githubusercontent.com/u/114292385',
  );

  group('Tests of IdentityRecordsService.getIdentityRecordsByAddress() method [GET in HTTP]', () {
    test('Should return [IRModel] if [server HEALTHY] and response [CAN be parsed to QueryIdentityRecordsByAddressResp]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      IRModel actualIrModel = await actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress);

      // Assert
      expect(actualIrModel, expectedRequesterIRModel);
    });

    test(
      'Should throw [DioParseException] if [server HEALTHY] and response [CANNOT be parsed to QueryIdentityRecordsByAddressResp] (e.g. response structure changed)',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        // Assert
        expect(
          actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress),
          throwsA(isA<DioParseException>()),
        );
      },
    );

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualIdentityRecordsService.getIdentityRecordsByAddress(actualWalletAddress),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of IdentityRecordsService.getInboundVerificationRequests() method [GET in HTTP]', () {
    test(
        'Should return [PageData<IRInboundVerificationRequestModel>] if [server HEALTHY] and response [CAN be parsed to QueryIdentityRecordVerifyRequestsByRequesterResp]',
        () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      PageData<IRInboundVerificationRequestModel> actualVerificationRequestsPageData = await actualIdentityRecordsService.getInboundVerificationRequests(
        QueryIdentityRecordVerifyRequestsByApproverReq(address: actualWalletAddress.bech32Address, offset: 0, limit: 10),
      );

      // Assert
      PageData<IRInboundVerificationRequestModel> expectedVerificationRequestsPageData = PageData<IRInboundVerificationRequestModel>(
        lastPageBool: true,
        blockDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
        cacheExpirationDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
        listItems: <IRInboundVerificationRequestModel>[
          IRInboundVerificationRequestModel(
            id: '1',
            requesterIrUserProfileModel: expectedIrUserProfileModel,
            tipTokenAmountModel: TokenAmountModel.fromString('200ukex'),
            dateTime: DateTime.parse('2021-09-30T12:00:00.000Z'),
            records: <String, String>{
              '3': 'somnitear',
            },
          ),
        ],
      );

      expect(actualVerificationRequestsPageData, expectedVerificationRequestsPageData);
    });

    test(
      'Should return [EMPTY PageData<IRInboundVerificationRequestModel>] if [server HEALTHY] and response [CANNOT be parsed to QueryIdentityRecordVerifyRequestsByRequesterResp] (e.g. response structure changed)',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        // Act
        PageData<IRInboundVerificationRequestModel> actualVerificationRequestsPageData = await actualIdentityRecordsService.getInboundVerificationRequests(
          QueryIdentityRecordVerifyRequestsByApproverReq(address: actualWalletAddress.bech32Address, offset: 0, limit: 10),
        );

        // Assert
        PageData<IRInboundVerificationRequestModel> expectedVerificationRequestsPageData = PageData<IRInboundVerificationRequestModel>(
          lastPageBool: true,
          blockDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
          cacheExpirationDateTime: DateTime.parse('2022-08-26 22:08:27.607Z'),
          listItems: const <IRInboundVerificationRequestModel>[],
        );

        expect(
          actualVerificationRequestsPageData,
          expectedVerificationRequestsPageData,
        );
      },
    );

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        () => actualIdentityRecordsService.getInboundVerificationRequests(
          QueryIdentityRecordVerifyRequestsByApproverReq(address: actualWalletAddress.bech32Address, offset: 0, limit: 10),
        ),
        throwsA(isA<DioConnectException>()),
      );
    });
  });

  group('Tests of IdentityRecordsService.getOutboundRecordVerificationRequests() method [GET in HTTP]', () {
    test('Should return [List of IRRecordVerificationRequestModel] if [server HEALTHY] and response [CAN be parsed to QueryIdentityRecordsByAddressResp]',
        () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://healthy.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Act
      List<IRRecordVerificationRequestModel> actualIrRecordVerificationRequestModels =
          await actualIdentityRecordsService.getOutboundRecordVerificationRequests(actualIrRecordModel);

      // Assert
      List<IRRecordVerificationRequestModel> expectedIrRecordVerificationRequestModels = <IRRecordVerificationRequestModel>[
        IRRecordVerificationRequestModel(
          verifierIrUserProfileModel: expectedIrUserProfileModel,
          irVerificationRequestStatus: IRVerificationRequestStatus.confirmed,
        )
      ];
      expect(actualIrRecordVerificationRequestModels, expectedIrRecordVerificationRequestModels);
    });

    test(
      'Should throw [DioParseException] if [server HEALTHY] and response [CANNOT be parsed to QueryIdentityRecordsByAddressResp] (e.g. response structure changed)',
      () async {
        // Arrange
        Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://invalid.kira.network/');
        await TestUtils.setupNetworkModel(networkUri: networkUri);

        // Assert
        expect(
          actualIdentityRecordsService.getOutboundRecordVerificationRequests(actualIrRecordModel),
          throwsA(isA<DioParseException>()),
        );
      },
    );

    test('Should throw [DioConnectException] if [server OFFLINE]', () async {
      // Arrange
      Uri networkUri = NetworkUtils.parseUrlToInterxUri('https://offline.kira.network/');
      await TestUtils.setupNetworkModel(networkUri: networkUri);

      // Assert
      expect(
        actualIdentityRecordsService.getOutboundRecordVerificationRequests(actualIrRecordModel),
        throwsA(isA<DioConnectException>()),
      );
    });
  });
}
